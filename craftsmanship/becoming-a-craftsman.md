[Home](/)

## My tale of becoming a craftsman
*// 20.03.2020*

### After university of applied science
I had the privilege to work on a green field project as a junior software engineer in a financial software company.
I worked on a project called [reghub](project-reghub.md) which needed to go live on a specific date because an european regulatory became effective beginning of 2018.
It was big fun. Colleagues were awesome. We discovered new technologies and made a lot of POCs. The GUI looked awesome and the business liked us. It seemed everything is possible and we developers are the kings. 

### Greenhorn
We had no idea that actually nobody of us really knew how to make proper software.
We all thought, as long as we are working in scrum methodology and were compliant with the [agile manifesto](https://agilemanifesto.org/), we were fine.
At the end we went live on christmas 2017 and achieved our target. Unfortunately we shaped the system in a way we hardly can change later on.

### Keeping the success
After two years, the project was not new anymore. Developers from around the world were coming and going. They could basically do whatever they want here. There was no design to follow, there was no quality gate to fulfill. There was no level of code maturity to remain.
We somehow slowed down. Discussions got longer and the same topics came back over and over again.
We reached a point where we had to stop writing features and work on some real bad technical debts. Sometimes our value to the business was zero.
  
### The new guy
A new guy joined the team. By this time I wasn't a junior developer anymore. I managed our jenkins and setup all the jobs which tested and built our artifacts.
After two weeks this new guy just pushed his changes to develop and this lead to a failing develop on our CI. I was under pressure and in charge of creating a new release. I needed this develop to be green!
I approached him quite angry and in my mind I already imagined him as an useless old guy who doesn't even know how to run tests and use git branches. Little did I know that this guy will change my life.

### the craftsman, the journeyman
After some time we figured out that this guy knows more than we first thought. He first proved his skills by writing very solid code and it seemed he always had already a plan B for everything, was just one step ahead.
At the end he was it, who rewrote the whole over-complicated and fucked up core of the application to a nicer piece of code which everybody can understand.
And the most important thing about him was: He did not destroy people in discussions, but started to teach us.

### Sharing the wisdom
He lend books (Clean architecture, the software craftsmanship) to other developers like me. 
Step by step we introduced code guidelines until we finally could enforce them. 
We wrote many automated tests that a refactoring is just as easy as writing new code.  

### It is all clear now
Looking back to this project, so many moments come back to my memory, where I totally failed as a software engineer. 
I agreed to so many things just because I was afraid to argue about it.
Now I know, software craftsmanship is black and white. Its that simple. If somebody writes code and annotate it with a //TODO you need to consider it as not done. **Every workaround** become the final implementation.