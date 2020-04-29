[Home](/)

## Project RegHub
*// 29.03.2020*

### Green field
After my studies at ZHAW I had the privilege to work on a green field project as a junior software engineer in a financial software company. This was from 2016 to 2020.
Our business unit of the company had the vision to start doing business in the financial regulatory sector. 
The idea was to provide a platform where financial institutes can share their regulatory data to be compliant with different regulations. 

### Deadline
There was big pressure since the beginning of the project to a specific date. An important european regulatory (mifid2) became effective beginning of 2018 and we needed to be ready in prod at latest this date, 
Otherwise our customers could be fined by the regulators.
Nevertheless it was big fun. Colleagues were awesome. We discovered new technologies and made a lot of POCs. The GUI looked awesome and the business liked us. It seemed everything is possible and the developers are the kings. 
We had no idea that actually nobody of us really knew how to make proper software.
I thought, as long as we are working in scrum methodology and were compliant with the [agile manifesto](https://agilemanifesto.org/), we were doing fine.
In december 18 we went live and achieved our target. We even received a big bonus for it.

### Decisions
We got some huge numbers and figures from our business about how much data, how many customer they except and how long we need to keep the data.
Based on the information we went with a distributed key-value-database (as we thought we go into big-data area and data-structure needs to be as weak as possible)
Also we ended up in buying a lot of servers with big specifications to be able to fulfill these big numbers.
Obviously there were a lot of decisions about technology, components and interfaces.
For decisions to be made, it was important that a senior developer gave his approval. As long as the decision was made from someone "high" enough, everybody else agreed to it as well. 
At this time all these decisions seemed right to me, I never questioned them. I only found out later that these decisions will come back into my own face. Not to those who actually made them.

### Different people, different ways of crafting software
The project was not new anymore. Developers (mostly externals) from around the world were coming and going. They could basically do whatever they want here. There was no design to follow, there was no quality-gate to fulfill. 
There was no level of code-maturity to uphold.
Then there was this guy who took cocaine and seemed to be really good at coding. He basically destroyed everybody in discussions, he came always up with facts nobody understood and always talked about his deep database knowledge.
He wrote the whole DAO layer which communicates with our not so user-friendly key-value store. We were actually happy with it, because he took the responsibility for it. Nobody questioned the outcome nor did we really understand it.
 
### Performance curve flattens
We somehow slowed down. Discussions got longer and the same topics came back over and over again. People started to fight instead of working together.
The management granted us time to work on our technical-debt stories and even provided us a dedicated scrum-master as our team of about 15 developers was not able to organize itself anymore. 
It gave a bit of structure to our daily work and at the end we all just tried to make our software better. But we were not able to do so.

### Whos fault is it? 
People got angry. Business came always with new ideas which did not fit into our landscape. We only could solve it with workarounds, instead of nicely adding a new feature. 
At one day, our company decided to quit all external contracts till the end of 2019. All people who wrote shitty code, made all the "bad" decisions and won all arguments, were gone.
So the answer is easy: Its the fault of the developers who stayed. Suddenly YOU take the ownership about everything in the past.  

### the craftsman, the journeyman
The project was two years old and a new guy joined the team. By this time I wasn't a junior developer anymore. I knew the system and all the insider stories and enjoyed the kudos of a problem-solver. 
One day this new guy just pushed some changes which lead to a failing develop on our CI. I was under pressure and in charge of creating a new release candidate. I needed this develop to be green.
I approached him quite angry and in my mind I already imagined him as an old guy who doesn't even know how to run tests and use git properly. Little did I know that this guy will change my life.
After some time we figured out that this guy knows more than we do. He first proved his skills by writing very solid code and it seemed he always had already a plan B for everything, was just one step ahead.
And the most important thing about him was: He did not destroy people in discussions, but started to teach others. 
At the end he was it, who rewrote the super complicated DAO layer and decoupled the business logic out of it. Step by step we introduced checkstyle and pmd checks and added so many tests that a refactoring is just as easy as writing new code.  

### It is all clear now
Looking back to this project, so many moments come back to my memory, where I totally failed as a software engineer. 
For example: If I didn't want to have a red develop branch, why was it even possible to push directly to it? Why didn't I raised my hand and said: Sry I actually do not agree.
Now I know, software craftsmanship is black and white. Its that simple. If somebody writes code and annotate it with a //TODO you need to consider it as not done. **Every workaround** become the final implementation.