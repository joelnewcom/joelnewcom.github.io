# Enterprise strategy

SAFe starts with the enterprise strategy. It is a plan to achieve the company's mission and should have answers to questions like:
* What customers do we want to serve?
* What products, resources and values do we want to bring/offer?
* How we want to enhance our services in the future?

To achieve an enterprise strategy, SAFe recommends the approach of defining in inputs and outputs:
The whole thing happens withing the Enterprise Portfolio Collaboration (Executives, Enterprise Architectures, Portfolio Stakeholders, Epic Owners)

Inputs: 
* Vision – What the business wants to be in the future
* Mission – How to achieve the vision 
* Core values – Its like code of conduct  
* Enterprise business drivers – What are the trends in the industry
* Distinctive competence – What can we do better than other companies
* Financial goals – To be clear and transparent to the stakeholders 
* Competitive environment – Competitive analysis 
* Portfolio context – Knowledge of the current state of each portfolio:
    * Portfolio vision (See section Portfolio)
    * Lean budget guardrails ()
    * Outcomes, Flow, competency (Metrics measures business outcomes)

Output:
* Portfolio budgets
* Strategic themes

## Enterprise Kanban
To support enterprise wide cross-cutting concerns, SAFe introduces Enterprise Kanban, which manages Enterprise Epics.  

# Portfolio
In big companies there are different/independent business units. To support this circumstances, SAFe introduces multiple portfolios.
Each portfolio has its own:
* Strategic themes
* value streams 
* Lean Budgets
* Portfolio Kanban (holds Portfolio epics)
* Portfolio vision (How to achieve the portfolios objectives, should be presented each PI planning)
* Portfolio canvas (Is an overview and definition of the portfolio)

Portfolio should make sure the cadence of its value-streams are synchronized.
A portfolio has one or multiple value-streams, to coordinate them SAFe uses a portfolio roadmap which consists of one or multiples solutions.

Roles in a portfolio (cross value-stream roles):
* Solution Portfolio Management – Responsible for guiding a portfolio to a set of integrated solutions
* Enterprise architecture - provides long term technical guidance
* APMO (Agile program management office) - supporting program execution
* RTE (Release train engineer) and STE (solution train engineer)

## Align enterprise strategy and portfolio
Its is the responsibility of LPM (Lean Portfolio Management) to align the portfolio to the enterprise strategy.
LPM with portfolio stakeholders can allocate money to the values stream within the portfolio.

## From portfolio into value-stream
LPM also checks the Portfolio epics via the portfolio kanban and accepts or rejects them. 
Once they are accepted they move into the Portfolio backlog.

After prioritizing the portfolio epics they get decomposed into Features or Capabilities which are managed in the program/solution kanban of one ART.
At the same time the epic on the portfolio kanban moves to implementation state. 

## Solution Train
One can split a solution into multiple ARTs. These ARTs all contribute to the same big solution.

* The solution-train has a Pre-PI and Post-PI planning rather than a PI planing.
* They have an Architecture-Sync meeting
* The solution to be built consists of multiple capabilities. 
* The solution defined as "solution intent" with strategies like Set-Based Design (Cross out bad options over time, but keep options open as long as possible)
* There is a solution roadmap which focuses on only the solution.
* Solution management 

# Features and Capabilities
A feature is on ART level and fulfills a stakeholders needs and should be done within one PI. 
A Capability is something which spans over multiple ARTs, to work on a capability, they are split into features. 

# PI
* Has a PI roadmap 
* Has PI objectives

# Roles
Solution Manager - Focuses on Capabilities. Helping on the Solution roadmap
Product Manager - Focuses on features. Helping on the PI roadmap, needs to sync with solution management.

