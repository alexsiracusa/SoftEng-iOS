//
//  Schema.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation

let CREATE_NODE_TABLE = """
CREATE TABLE IF NOT EXISTS Node (
    id          TEXT        PRIMARY KEY,
    xcoord      INT,
    ycoord      INT,
    floor       TEXT        CHECK (floor IN ('L1', 'L2', '1', '2', '3')),
    building    TEXT,
    type        TEXT        CHECK (type IN ('CONF', 'DEPT', 'HALL', 'LABS', 'REST',
                                            'SERV', 'ELEV', 'EXIT', 'STAI', 'RETL',
                                            'INFO', 'BATH')),
    long_name   TEXT,
    short_name  TEXT
) STRICT;
"""

let CREATE_EDGE_TABLE = """
CREATE TABLE IF NOT EXISTS Edge (
    id          TEXT        PRIMARY KEY,
    start_id    TEXT        REFERENCES node(id),
    end_id      TEXT        REFERENCES node(id),
    blocked     INT,        -- actuall a Bool, 0 or 1
    heat        INT
) STRICT;
"""

let CREATE_SAVED_NODE_TABLE = """
CREATE TABLE IF NOT EXISTS Saved_Node (
    node_id     TEXT,

    PRIMARY KEY (node_id)
) STRICT;
"""

let SCHEMA = """

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Saved_Node;
DROP TABLE IF EXISTS Edge;
DROP TABLE IF EXISTS Node;

\(CREATE_NODE_TABLE)

\(CREATE_EDGE_TABLE)

\(CREATE_SAVED_NODE_TABLE)

"""



