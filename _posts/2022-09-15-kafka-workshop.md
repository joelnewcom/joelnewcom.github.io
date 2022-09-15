---
layout: single
title:  "Vanilla Java Kafka producer and consumer snippets"
date:   2022-09-15 00:00:00 +0200
categories: kafka
---

# Prerequisites

Downloading kafka_2.13-3.0.1-company.zip and unzip it under a short path ("C:\Git\kafka-workshop\kafka") without any
whitespace.
This zip holds a kafka client, certificates and the kafka.config file to communicate with Kafka dev instance in the
company.

kafka.config:

```
# Change defaults for your respective client certificate/truststore
security.protocol=SSL
ssl.truststore.location=truststore.jks
ssl.truststore.password=changeme
ssl.keystore.location=test-account-x-dev.pfx
ssl.keystore.type=PKCS12
ssl.key.password=changeme
ssl.keystore.password=changeme
 
# Kafka bootstrap
bootstrap.servers=kafka.company.ch:443
 
# SR
schema.registry.url=https://registry.kafka.company.ch:443
```

First thing to do is using git bash to call following commands:

## CLI commands

The url of the real kafka instance is replaced by: kafka.company.ch

### Test Configuration

```
./bin/kafka-broker-api-versions.sh --bootstrap-server kafka.company.ch:443 --command-config kafka.config
```

### Create Topic

```
./bin/kafka-topics.sh --create --partitions 10 --replication-factor 2 --topic test.topic.joel --bootstrap-server kafka.company.ch:443 --command-config kafka.config
```

#### Create another topic for messages with schema

```
./bin/kafka-topics.sh --create --partitions 10 --replication-factor 2 --topic test.topic.joel.schemaregister --bootstrap-server kafka.company.ch:443 --command-config kafka.config
```

### Produce Message

```
./bin/kafka-console-producer.sh --topic test.topic.joel --bootstrap-server kafka.company.ch:443 --producer.config kafka.config
```

### Consume Message

```
./bin/kafka-console-consumer.sh --topic test.topic.joel --from-beginning --bootstrap-server kafka.company.ch:443 --consumer.config kafka.config
```

# Workshop 1 - Producer

This code snipped represents a simple producer. It just sends a single message to a kafka instance.

```
// removed package and import statements 

public class KafkaWorkshop {

    public static final String TOPIC_NAME = "test.topic.joel";
    private static final Properties props = new Properties();
    private static final Logger LOG = LoggerFactory.getLogger(KafkaWorkshop.class.getName());

    public static void main(String[] args) throws InterruptedException, IOException {
        initializeProperties();

        // register shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread(() ->
                LOG.info("========== Shutting down Kafka client.")));

        String id = UUID.randomUUID().toString();

        // Insert your code here
        try (KafkaProducer<String, String> producer = new KafkaProducer<String, String>(props)) {
            final ProducerRecord<String, String> producerRecord = new ProducerRecord<>(
                    TOPIC_NAME, id, String.format("%s - Hello world - Joel", id));

            LOG.info("sending a record number {}", id);

            var response = producer.send(producerRecord);
            // Making it synchronous for testing purposes
            producer.flush();

            var recordMetadata = response.get();

            LOG.info(" successfully got response of id: {} on topic: {}", id, TOPIC_NAME);

            LOG.info(" record metadata offset: {}", recordMetadata.offset());
        } catch (ExecutionException e) {
            LOG.error("failed with error: ");
        }

    }

    private static void initializeProperties() throws IOException {
        PropertiesFileLoader.loadPropertiesFromApplicationProperties(props);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
    }
}

```

Instead of kafka.config we now use an application.properties file with basically the same information:

```
# Change defaults for your respective client certificate/truststore
security.protocol=SSL
ssl.truststore.location=../../kafka/truststore.jks
ssl.truststore.password=changeme
ssl.keystore.location=../../kafka/test-account-x-dev.pfx
ssl.keystore.type=PKCS12
ssl.key.password=changeme
ssl.keystore.password=changeme
# this disables DNS hostname verification
# ssl.endpoint.identification.algorithm=

# Kafka bootstrap
bootstrap.servers=kafka.company.ch:443

# SR
schema.registry.url=https://registry.kafka.company.ch:443
```

To load the application.properties file we this little class

```
// removed package and import statements for simplicity

public class PropertiesFileLoader {

    private PropertiesFileLoader() {}

    /**
     * Reads properties from src/main/resources/application.properties file and
     * stores them into Properties object.Can override existing properties.
     * @param properties
     * @input Properties properties object
     * @throws IOException issues with accessing config file
     * */
    public static void loadPropertiesFromApplicationProperties(Properties properties) throws IOException {
        try (var stream = PropertiesFileLoader.class.getResourceAsStream("/application.properties")){
            properties.load(stream);
        }
    }
}
```

The pom.xml is simple and basically only defines the kafka client to be used

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>ch.workshop.kafka</groupId>
    <artifactId>kafka-workshop</artifactId>
    <version>1.0-SNAPSHOT</version>
    
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <exec.mainClass>ch.workshop.kafka.KafkaWorkshop</exec.mainClass>
        <kafka-clients.version>3.0.0</kafka-clients.version>
        <logback-classic.version>1.2.10</logback-classic.version>
    </properties>
    
    <dependencies>
        <!-- Apache Kafka vanilla consumer/producer -->
        <dependency>
            <groupId>org.apache.kafka</groupId>
            <artifactId>kafka_2.13</artifactId>
            <version>${kafka-clients.version}</version>
        </dependency>
        <!-- Logging -->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>${logback-classic.version}</version>
        </dependency>

    </dependencies>
</project>
```

# workshop 2 - Consumer

This code snipped demonstrates a simple java kafka consumer. Its iterating forever and polls for a specific topic.
The application.properties, the pom.xml and the PropertiesFileLoader.java is the same as in workshop 1.

```
// removed package and import statements

public class KafkaWorkshop {
    public static final String TOPIC_NAME = "test.topic.joel";
    private static final Properties props = new Properties();
    private static final Logger LOG = LoggerFactory.getLogger(KafkaWorkshop.class.getName());
    private static int count = 0;

    public static void main(String[] args) throws Exception {
        initializeProperties();

        // register shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread(() ->
                LOG.info("===================Shutting down - consumed messages in the queue.")));

        // Insert your code here
        try (KafkaConsumer<String, String> consumer = new KafkaConsumer<String, String>(props)){
            consumer.subscribe(List.of(TOPIC_NAME));
            while(true){
                ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(1000));
                var recordCount = records.count();

                if (recordCount != 0){
                    LOG.info("polled {} record", recordCount );

                    for (ConsumerRecord<String, String> record: records){
                        LOG.info("key: {} and value: {}", record.key(), record.value());
                        LOG.info("total count: {}", count++);
                    }
                }
            }
        }
    }

    private static void initializeProperties() throws IOException {
        String id = UUID.randomUUID().toString();
        PropertiesFileLoader.loadPropertiesFromApplicationProperties(props);
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        // This parameter ensures we receive EcmEvent instead of org.apache.avro.generic.GenericData$Record
        props.put(ConsumerConfig.GROUP_ID_CONFIG, id);
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest"); // or: latest (Only fetches event which come in after we started)
        props.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, "10");
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, true);
    }
}

```

# Workshop 3 - Producer with Schema

Same as Workshop 1, but with a specific avro schema registered and sending its generated object (UserJoel), instead of a
string.

```
// removed package and import statements

public class KafkaWorkshop {

    public static final String TOPIC_NAME = "test.topic.joel.schemaregister";
    private static final Properties props = new Properties();
    private static final Logger LOG = LoggerFactory.getLogger(KafkaWorkshop.class.getName());

    public static void main(String[] args) throws InterruptedException, IOException {
        initializeProperties();

        // register shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread(() ->
                LOG.info("========== Shutting down Kafka client.")));

        String id = UUID.randomUUID().toString();

        // Insert your code here
        try (KafkaProducer<String, UserJoel> producer = new KafkaProducer<String, UserJoel>(props)) {
            final var user = new UserJoel(42, "green", BigDecimal.ONE);
            final var producerRecord = new ProducerRecord<String, UserJoel>(TOPIC_NAME, id, user);
            LOG.info(" sending data record number {}", id);
            var response = producer.send(producerRecord);
            producer.flush();
            var recordMetadata = response.get();
            LOG.info("record offset: {}, and partition: {}", recordMetadata.offset(), recordMetadata.partition());

        } catch (ExecutionException e) {
            LOG.error("error", e);
        }
    }

    private static void initializeProperties() throws IOException {
        PropertiesFileLoader.loadPropertiesFromApplicationProperties(props);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);
    }
}

```

The avro schema is defined like this:

```
{"namespace": "ch.workshop.kafka",
  "type": "record",
  "name": "UserJoel",
  "fields": [
    //{"name": "name", "type": "string"},
    {"name": "favorite_number",  "type": ["int", "null"]},
    {"name": "favorite_color", "type": ["string", "null"]},
    {"name": "hourly_rate", "type": {
      "type": "bytes",
      "logicalType": "decimal",
      "precision": 4,
      "scale": 2
    }}
  ]
}
```

pom.xml defines where to find the avro schemas and where avro-maven-plugin shall put the generated class into. (
${project.build.directory}/generated-sources/avro)

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>ch.workshop.kafka</groupId>
    <artifactId>kafka-workshop</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <exec.mainClass>ch.workshop.kafka.KafkaWorkshop</exec.mainClass>
        <kafka-clients.verison>3.0.0</kafka-clients.verison>
        <logback-classic.version>1.2.10</logback-classic.version>
        <avro.version>1.11.0</avro.version>
        <schema-registry.version>7.0.1</schema-registry.version>
    </properties>

    <dependencies>
        <!-- Apache Kafka vanilla consumer/producer -->
        <dependency>
            <groupId>org.apache.kafka</groupId>
            <artifactId>kafka_2.13</artifactId>
            <version>${kafka-clients.verison}</version>
        </dependency>
        <!-- Logging -->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>${logback-classic.version}</version>
        </dependency>
        <!-- AVRO dependencies -->
        <dependency>
            <groupId>org.apache.avro</groupId>
            <artifactId>avro</artifactId>
            <version>${avro.version}</version>
            <exclusions>
                <exclusion>
                    <groupId>org.apache.kafka</groupId>
                    <artifactId>kafka-clients</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <dependency>
            <groupId>io.confluent</groupId>
            <artifactId>kafka-avro-serializer</artifactId>
            <version>${schema-registry.version}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.avro</groupId>
                <artifactId>avro-maven-plugin</artifactId>
                <version>${avro.version}</version>
                <executions>
                    <execution>
                        <phase>generate-resources</phase>
                        <goals>
                            <goal>idl-protocol</goal>
                            <goal>schema</goal>
                        </goals>
                        <configuration>
                            <sourceDirectory>src/main/resources/avroSchema</sourceDirectory>
                            <outputDirectory>${project.build.directory}/generated-sources/avro</outputDirectory>
                            <enableDecimalLogicalType>true</enableDecimalLogicalType>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
    <repositories>
        <repository>
            <id>confluent</id>
            <url>https://packages.confluent.io/maven/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </repository>
    </repositories>
    <distributionManagement>
        <repository>
            <id>confluent</id>
            <url>https://packages.confluent.io/maven/</url>
        </repository>
    </distributionManagement>
</project>
```

# Workshop 4 - Consumer with Schema

```
// removed package and import statements for simplicity

public class KafkaWorkshop {

    public static final String TOPIC_NAME = "test.topic.joel.schemaregister";
    private static final Properties props = new Properties();
    private static final Logger LOG = LoggerFactory.getLogger(KafkaWorkshop.class.getName());

    public static void main(String[] args) throws InterruptedException, IOException {
        initializeProperties();

        // register shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread(() ->
                LOG.info("========== Shutting down Kafka client.")));

        String id = UUID.randomUUID().toString();

        // Insert your code here
        try (KafkaProducer<String, UserJoel> producer = new KafkaProducer<String, UserJoel>(props)) {
            final var user = new UserJoel(42, "green", BigDecimal.ONE);
            final var producerRecord = new ProducerRecord<String, UserJoel>(TOPIC_NAME, id, user);
            LOG.info(" sending data record number {}", id);
            var response = producer.send(producerRecord);
            producer.flush();
            var recordMetadata = response.get();
            LOG.info("record offset: {}, and partition: {}", recordMetadata.offset(), recordMetadata.partition());

        } catch (ExecutionException e) {
            LOG.error("error", e);
        }
    }

    private static void initializeProperties() throws IOException {
        PropertiesFileLoader.loadPropertiesFromApplicationProperties(props);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);
    }
}
```

# Workshop 5 - Spring event streaming

This demonstrates how Kafka works in a Spring project.

Spring REST controller which sends the content of the POST body into Kafka.

```
// removed package and import statements for simplicity

@RestController
@RequestMapping("/workshop")
public class KafkaController {

    private final KafkaService service;

    public KafkaController(KafkaService service) {
        this.service = service;
    }

    @PostMapping("/kafka")
    public ResponseEntity<String> postBody(@RequestBody String message) {
        // Insert your code here
        try {
            String response = service.send(message);
            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .contentType(MediaType.TEXT_HTML)
                    .body(response);
        } catch (Exception ex) {
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.TEXT_HTML)
                    .body(ex.getLocalizedMessage());
        }

    }
}
```

The kafka service, which communicates with kafka.

```
// removed package and import statements for simplicity

@Service
public class KafkaService {

    private static final Logger LOG = LoggerFactory.getLogger(KafkaService.class.getName());

    private final KafkaTemplate template;
    private final String topic;

    public KafkaService(KafkaTemplate template, @Value("${topic.name}") String topic) {
        this.template = template;
        this.topic = topic;
    }

    public String send(String message) {
        // Insert your code here
        try {
            var response = template.send(topic, null, message);
            var recordMetaData = ((SendResult) response.get()).getRecordMetadata();
            return String.format("Message sent - offset: %s, partition: %s", recordMetaData.offset(), recordMetaData.partition());
        } catch (ExecutionException | InterruptedException e) {
            LOG.error("An error happened", e);
            throw new RuntimeException("whatever");
        }
    }

    @RetryableTopic(
            attempts = "3",
            backoff = @Backoff(delay = 1000, multiplier = 2.0),
            autoCreateTopics = "true",
            topicSuffixingStrategy = TopicSuffixingStrategy.SUFFIX_WITH_INDEX_VALUE
    )
    @KafkaListener(topics = "${topic.name}", groupId = "${plain.consumer.groupId}")
    public void consume(String message, @Header(KafkaHeaders.RECEIVED_TOPIC) String topic) throws IOException {
        LOG.info(String.format("#### Consumed Message: %s from topic %s", message, topic));

        // Throws an error when a message is prefixed with 'dlq' to get a messages into DLQ for testing.
        if (message.startsWith("dlq")) {
            throw new IllegalStateException("Failed");
        }
    }

    @DltHandler
    public void dlt(String message, @Header(KafkaHeaders.RECEIVED_TOPIC) String topic) {
        LOG.info(String.format("#### DLQ: %s from topic %s", message, topic));
    }
}
```

The application.yaml file gives kafka client the needed configuration,
just like the kafka.config in workshop 1 and application.properties in the previous workshops.

```
topic:
  name: test.topic.joel
plain:
  consumer:
    groupId: 111222333

server:
  port: 8080
  
spring:
  kafka:
    security:
      protocol: "SSL"
    bootstrap-servers: kafka.company.ch:443
    ssl:
      trust-store-location: "file:../../kafka/truststore.jks"
      trust-store-password: changeme
      key-store-location: "file:../../kafka/test-account-x-dev.pfx"
      key-store-password: changeme
      key-password: changeme
      key-store-type: PKCS12
    consumer:
      group-id: group-0-joel
      auto-offset-reset: earliest
      key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
      value-deserializer: org.apache.kafka.common.serialization.StringDeserializer
    producer:
      key-serializer: org.apache.kafka.common.serialization.StringSerializer
      value-serializer: org.apache.kafka.common.serialization.StringSerializer

```

pom.xml defines vanilla spring-boot and kafka

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
        
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.7</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
        
    <groupId>ch.workshop.kafka</groupId>
    <artifactId>kafka-workshop</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>kafka-workshop</name>
    <description>Demo project for Spring Boot</description>
        
    <properties>
        <!-- Plugin Versions -->
        <maven-compiler-version>3.8.1</maven-compiler-version>
        <!-- Settings -->
        <encoding>UTF-8</encoding>
        <project.build.sourceEncoding>${encoding}</project.build.sourceEncoding>
        <project.reporting.outputEncoding>${encoding}</project.reporting.outputEncoding>
        <argLine>-Dfile.encoding=${encoding}</argLine>
        <java.version>11</java.version>
        <maven.compiler.source>${java.version}</maven.compiler.source>
        <maven.compiler.target>${java.version}</maven.compiler.target>
        <maven.compiler.showDeprecation>true</maven.compiler.showDeprecation>
        <maven.compiler.showWarnings>true</maven.compiler.showWarnings>
    </properties>
        
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.kafka</groupId>
            <artifactId>spring-kafka</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.kafka</groupId>
            <artifactId>spring-kafka-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            <!-- Reveals missing details about unchecked or unsafe operations. -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${maven-compiler-version}</version>
                <configuration>
                    <compilerArgument>-Xlint:unchecked</compilerArgument>
                </configuration>
            </plugin>
        </plugins>
        
    </build>

</project>
```
