[Home](/)

## Project RegHub
*// 29.03.2020*

### Green field
After my studies at ZHAW I had the privilege to work on a green field project as a junior software engineer in a financial software company. This was from 2016 to 2020.
Our business unit of the company had the vision to start doing business in the financial regulatory sector. 
The idea was to provide a platform where financial institutes can share their regulatory data to be compliant with different regulations. 

### Deadline
There was a big pressure since the beginning of the project to a specific date. An important european regulatory (mifid2) became effective beginning of 2018 and we needed to be ready in prod at latest this date. Otherwise our customers could be fined by the regulators.
Nevertheless it was big fun. Colleagues were awesome. We discovered new technologies and made a lot of POCs. The GUI looked awesome and the business liked us. It seemed everything is possible and we developers are the kings. 
We had no idea that actually nobody of us really knew how to make proper software.
I thought, as long as we are working in scrum methodology and were compliant with the [agile manifesto](https://agilemanifesto.org/), we were doing fine.
In december 18 we went live and achieved our target.

### Decisions were made
We used a distributed key-value-database as we thought we go into big-data area and data-structure needs to be as weak as possible. 
The argument for key-value over a relational database was something like:
 
* Its impossible to make a backup of a normal relational database with this huge amount of data we are excepting. 
* ACID functionality of oracle noSQL, as every other noSQL store doesn't have it.

We separated the input process from the normal application into an own component and defined REST-interface between them. Only later I found out [conway's law](http://www.melconway.com/Home/Conways_Law.html) was a thing. 
We decided to use xml based spring bean configuration and use apache camel as framework for our data-intake component. 
We decided to buy super powerful servers to give our database the boost it needed to run fast. Without any load on the system we already agreed on having the best and most expensive hardware we can get.
For decisions to be made, it was important that a senior developer gave his approval to it. As long as the decision was made from someone "high" everybody agreed to it. 
At this time all these decisions seemed right to me, I never questioned them. I only found out later these decisions will come back in my own face. Not to those who actually made and pushed them.

### Different people, different ways of crafting software
The project was not new anymore. Developers from around the world were coming and going. They could basically do whatever they want here. There was no design to follow, there was no quality gate to fulfill. There was no level of code maturity to remain.
There were a lot of external people. There was this guy who took cocaine and seemed to be really good at coding. He destroyed everybody in discussions, he came always up with facts nobody understood and always talked about his deep database knowledge.
He wrote the whole DAO layer which communicates with our not so user-friendly key-value store. We were actually happy with it, because he took the responsibility for it. Nobody questioned his outcome nor did we really understand it. He was just too fast. 
 
### Performance curve flattens
We somehow slowed down. Discussions got longer and the same topics came back over and over again.
The management granted us time to work on our technical debt stories and even provided us a real scrum master as our team was not able to organize itself anymore. It did actually help. It helped the team to act as a team, it gave a structure in our work and we all really tried to make our software better.
But we were not able to do so.

### Whos fault is it? 
People got angry. We were angry. Business came always with new ideas which did not fit into our landscape. We only could solve it with temporary workarounds. 
Sometimes we didn't even know if a feature was for the customer or for our business, because they could not get the data out of our existing API how they wanted it. 
Our company decided to quit all external contracts till the end of 2019. All people who wrote code like hell, made all decisions and won all arguments were gone.  
 
### the craftsman, the journeyman
The project was two years old and a new guy joined the team. By this time I wasn't a junior developer anymore. I managed our jenkins and setup all the jobs which tested and built our artifacts.
After two weeks this new guy just pushed his changes to develop and this lead to a failing develop on our CI. I was under pressure and in charge of creating a new release. I needed this develop to be green.
I approached him quite angry and in my mind I already imagined him as an useless old guy who doesn't even know how to run tests and use git branches. Little did I know that this guy will change my life.
After some time we figured out that this guy knows more than we do. He first proved his skills by writing very solid code and it seemed he always had already a plan B for everything, was just one step ahead.
And the most important thing about him was: He did not destroy people in discussions, but started to teach us. 
At the end he was it, who rewrote the core (DAO layer) and decoupled the business logic out of it. Step by step we introduced checkstyle and pmd checks and added so many tests that a refactoring is just as easy as writing new code.  

### It is all clear now
Looking back to this project, so many moments come back to my memory, where I totally failed as a software engineer. 
For example: If I didn't want to have a red develop branch, why was it even possible to push directly to it? Why didn't I raised my hand and said: Sry I actually do not agree.
Now I know, software craftsmanship is black and white. Its that simple. If somebody writes code and annotate it with a //TODO you need to consider it as not done. **Every workaround** become the final implementation.