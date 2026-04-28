
Challenge 1 - The Brokers of Knowhere

Your ship, the Milano, barely survived the crash. The engines are dead, the navigation system is fried, and the hyperdrive core is missing a crucial stabilizer.

A distress signal leads you to Knowhere, a black market colony carved inside the skull of an ancient celestial. If anyone can help you find the missing parts, it is the brokers who trade across this underground network.

A Ravager mechanic named Rax hands you access to the broker registry.

> “Start there. Figure out who's who in this mess.”

<details><summary>Statement</summary>List all brokers and the parts they currently possess.<br><br>
</details><br>


Trade Graph Setup - Knowledge Upgrade!

After reviewing the broker registry, Rax opens a hidden market map.

> “Nobody sells direct around here. Everything moves through broker chains.”

To make sense of the market, you need to model it as a property graph. 

 IMPORTANT: Before you start querying please enter LOAD duckpgq; 

<details><summary>Statement</summary>Create the property graph trade_graph using brokers as vertices and trades as edges.<br><br>
</details><br>


Challenge 2 - Following the Trades

Most brokers do not hold parts themselves. Instead, they pass goods across a web of trades.

Rax shows you a simple graph query and taps one missing detail.

> “Every trade costs credits. If you want to survive in this market, pay attention to the cost.”

<details><summary>Statement</summary>List all broker-to-broker trades and include the cost of each trade.<br><br>
</details><br>


Challenge 3 - The Ion Thruster Lead

You overhear a conversation in the market.

> “Kraglin's looking for an Ion Thruster again.”
> “Yeah, but he doesn't have one. He trades with someone who does.”

Rax smirks.

> “Follow the credits, kid. The cheapest deal usually points to the real supplier.”

<details><summary>Statement</summary>Find the cheapest direct trade leading to a broker who has the Ion Thruster.<br><br>
</details><br>


Challenge 4 - The Middleman Problem

Rax looks over the result and shakes his head.

> “Too expensive.”
> “If you want a better price, you gotta go through a middleman.”

On Knowhere, parts often move through chains of brokers before reaching a buyer. Sometimes a longer route is cheaper overall.

<details><summary>Statement</summary>Find two-step trade routes that lead to a broker holding the Plasma Regulator.<br><br>
</details><br>


Challenge 5 - The Flux Coil Trail

A frantic trader shoves past you.

> “Flux coil just moved through the market!”

The Quantum Flux Coil is rare, volatile, and constantly changing hands.

Rax nods toward the graph.

> “Track the brokers connected to whoever holds it. That's your supply chain.”

<details><summary>Statement</summary>Find brokers connected to the broker holding the Quantum Flux Coil.<br><br>
</details><br>


Challenge 6 - The Cheapest Route

You finally know where the Ion Thruster is. But the direct trades are outrageous.

Rax lowers his voice.

> “Listen carefully. In this market, the cheapest path is rarely the shortest.”

To afford the part, you need the lowest-cost chain of trades through the network.

<details><summary>Statement</summary>Find the lowest-cost trade path to the broker holding the Ion Thruster.<br><br>
</details><br>


Final Scene - Escape from Knowhere

With the cheapest trade routes mapped, you secure the Ion Thruster, Plasma Regulator, and Quantum Flux Coil. Rax helps you install them into the Milano.

The engines roar back to life.

> “Not bad, kid.”
> “You just navigated the most complicated trade network in the galaxy.”

As the Milano lifts off from Knowhere, the console flashes one final status update:

> Ship status: Fully operational
> Destination: Open space

