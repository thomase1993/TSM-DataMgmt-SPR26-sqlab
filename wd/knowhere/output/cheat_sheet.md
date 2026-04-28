# Cheat sheet

## Adventure

### Episode 1

**Token.** 42.

List all brokers and the parts they currently possess.

**Formula**. `salt_042(sum(nn(b.hash)) OVER ()) AS token`

Rax was right: the registry shows exactly who holds what.

```sql
SELECT b.name, b.part, salt_042(sum(nn(b.hash)) OVER ()) AS token
FROM brokers b;
```

## Adventure

### Episode 1

**Token.** 520386565.

Create the property graph trade_graph using brokers as vertices and trades as edges.

**Formula**. `salt_012(sum(nn(t.hash)) OVER ()) AS token`

With the graph created, the market stops looking like chaos and starts looking like a network.

```sql
CREATE OR REPLACE PROPERTY GRAPH IF NOT EXISTS trade_graph
VERTEX TABLES (brokers)
EDGE TABLES (
  trades
    SOURCE KEY (from_broker_id) REFERENCES brokers (broker_id)
    DESTINATION KEY (to_broker_id) REFERENCES brokers (broker_id)
);

SELECT 1 AS graph_ready, salt_012(sum(nn(t.hash)) OVER ()) AS token
FROM trades t;
```

### Episode 3

**Token.** 956530460.

List all broker-to-broker trades and include the cost of each trade.

**Formula**. `salt_078(sum(nn(a.hash)) OVER ()) AS token`

Now you can see not just who trades with whom, but how expensive every deal is.

```sql
SELECT from_broker, to_broker, cost, salt_078(sum(nn(a.hash)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:brokers)-[t:trades]->(b:brokers)
  COLUMNS (
    a.name AS from_broker,
    b.name AS to_broker,
    t.cost AS cost
  )
);
```

### Episode 4

**Token.** 36405126.

Find the cheapest direct trade leading to a broker who has the Ion Thruster.

**Formula**. `salt_010(sum(nn(a.hash)) OVER ()) AS token`

That is the cheapest direct route to the Ion Thruster supplier.

```sql
SELECT seller, supplier, cost, salt_010(sum(nn(a.hash)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:brokers)-[t:trades]->(b:brokers)
  WHERE b.part = 'Ion Thruster'
  COLUMNS (
    a.name AS seller,
    b.name AS supplier,
    t.cost AS cost
  )
)
ORDER BY cost
LIMIT 1;
```

### Episode 4

**Token.** 526689464.

Find two-step trade routes that lead to a broker holding the Plasma Regulator.

**Formula**. `salt_080(sum(nn(a.hash)) OVER ()) AS token`

Two-step routes reveal the hidden bargains buried inside the market chain.

```sql
SELECT start, middleman, supplier, total_cost, salt_080(sum(nn(a.hash)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:brokers)-[t1:trades]->(b:brokers)-[t2:trades]->(c:brokers)
  WHERE c.part = 'Plasma Regulator'
  COLUMNS (
    a.name AS start,
    b.name AS middleman,
    c.name AS supplier,
    t1.cost + t2.cost AS total_cost
  )
)
ORDER BY total_cost;
```

### Episode 5

**Token.** 476376544.

Find brokers connected to the broker holding the Quantum Flux Coil.

**Formula**. `salt_023(sum(nn(a.hash)) OVER ()) AS token`

These brokers are directly connected to the current Quantum Flux Coil holder.

```sql
SELECT broker, coil_holder, salt_023(sum(nn(a.hash)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:brokers)-[:trades]->(b:brokers)
  WHERE b.part = 'Quantum Flux Coil'
  COLUMNS (
    a.name AS broker,
    b.name AS coil_holder
  )
);
```

### Episode 6

**Token.** 945921625.

Find the lowest-cost trade path to the broker holding the Ion Thruster.

**Formula**. `salt_045(sum(nn(a.hash)) OVER ()) AS token`

The market finally gives up its secret: the cheapest path, not the shortest-looking one.

```sql
SELECT start, destination, total_cost, salt_045(sum(nn(a.hash)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH SHORTEST_PATH (a:brokers)-[t:trades*]->(b:brokers)
  WHERE b.part = 'Ion Thruster'
  COLUMNS (
    a.name AS start,
    b.name AS destination,
    SUM(t.cost) AS total_cost
  )
);
```

### Episode 7

**Token.** 299810560.


