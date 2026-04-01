CREATE TABLE brokers (
    id INT, 
    name VARCHAR, 
    part VARCHAR,
    extra_part_1 VARCHAR,
    extra_part_2 VARCHAR,
    hash BIGINT DEFAULT 0
);

CREATE TABLE trades (
    source_id INT, 
    target_id INT, 
    cost INT,
    hash BIGINT DEFAULT 0
);

CREATE PROPERTY GRAPH trade_graph
VERTEX TABLES (
    brokers LABEL Broker
)
EDGE TABLES (
    trades SOURCE KEY (source_id) REFERENCES brokers(id)
           DESTINATION KEY (target_id) REFERENCES brokers(id)
           LABEL TRADES_WITH
);