## Knowhere Black Market: Challenge Access and Solutions

Below is a clean reference guide for jumping directly into each challenge and running the matching solution query.

### Open a specific challenge

Use these commands to jump straight to a challenge without playing through the whole story:

```sql
SELECT * FROM decrypt(42);         -- Challenge 1
SELECT * FROM decrypt(520386565);  -- Practice / Knowledge Upgrade
SELECT * FROM decrypt(956530460);  -- Challenge 2
SELECT * FROM decrypt(36405126);   -- Challenge 3
SELECT * FROM decrypt(526689464);  -- Challenge 4
SELECT * FROM decrypt(476376544);  -- Challenge 5
SELECT * FROM decrypt(945921625);  -- Challenge 6
SELECT * FROM decrypt(299810560);  -- Challenge 7 / Ending scene
```

Challenge 7 is the final scene and credits roll. It does not contain an actual task.

---

## Solution queries

These queries already include the correct `salt_...` token logic.

### Challenge 1 solution

```sql
SELECT name, part, salt_042(sum(nn(hash)) OVER ()) AS token
FROM brokers;
```

### Practice / Knowledge Upgrade prerequisite

If you skip directly to the graph section, make sure the extension is loaded first:

```sql
LOAD duckpgq;
```

### Practice / Knowledge Upgrade solution

```sql
SELECT 1 AS graph_ready, salt_012(sum(nn(t.hash)) OVER ()) AS token
FROM trades t
LIMIT 1;
```

### Challenge 2 solution

```sql
SELECT from_broker, to_broker, cost, salt_078(sum(nn(hash_a)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:Broker)-[t:TRADES_WITH]->(b:Broker)
  COLUMNS (
    a.name AS from_broker,
    b.name AS to_broker,
    t.cost AS cost,
    a.hash AS hash_a
  )
);
```

### Challenge 3 solution

```sql
SELECT seller, supplier, cost, salt_010(sum(nn(hash_a)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:Broker)-[t:TRADES_WITH]->(b:Broker)
  WHERE b.part = 'Ion Thruster'
  COLUMNS (
    a.name AS seller,
    b.name AS supplier,
    t.cost AS cost,
    a.hash AS hash_a
  )
)
ORDER BY cost
LIMIT 1;
```

### Challenge 4 solution

```sql
SELECT start, middleman, supplier, total_cost, salt_080(sum(nn(hash_a)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:Broker)-[t1:TRADES_WITH]->(b:Broker)-[t2:TRADES_WITH]->(c:Broker)
  WHERE c.part = 'Plasma Regulator'
  COLUMNS (
    a.name AS start,
    b.name AS middleman,
    c.name AS supplier,
    t1.cost + t2.cost AS total_cost,
    a.hash AS hash_a
  )
)
ORDER BY total_cost;
```

### Challenge 5 solution

```sql
SELECT broker, coil_holder, salt_023(sum(nn(hash_a)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH (a:Broker)-[t:TRADES_WITH]->(b:Broker)
  WHERE b.part = 'Quantum Flux Coil'
  COLUMNS (
    a.name AS broker,
    b.name AS coil_holder,
    a.hash AS hash_a
  )
);
```

### Challenge 6 solution

```sql
SELECT start, destination, hops, salt_045(sum(nn(hash_a)) OVER ()) AS token
FROM GRAPH_TABLE (
  trade_graph
  MATCH p = ANY SHORTEST (a:Broker)-[t:TRADES_WITH]->{1,10}(b:Broker)
  WHERE b.part = 'Ion Thruster'
  COLUMNS (
    a.name AS start,
    b.name AS destination,
    path_length(p) AS hops,
    a.hash AS hash_a
  )
);
```

---

## Notes

* Challenge 6 uses the shortest supported path form in the current setup, returning `hops` rather than a weighted total cost.
