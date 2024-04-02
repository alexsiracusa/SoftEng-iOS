//
//  Schema.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation

let SCHEMA = """


PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Flower_Request;
DROP TABLE IF EXISTS Maintenance_Request;
DROP TABLE IF EXISTS Service_Request;
DROP TABLE IF EXISTS Edge;
DROP TABLE IF EXISTS Node;

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

CREATE TABLE IF NOT EXISTS Edge (
    id          TEXT        PRIMARY KEY,
    start_id    TEXT        REFERENCES node(id),
    end_id      TEXT        REFERENCES node(id),
    blocked     INT,        -- actuall a Bool, 0 or 1
    heat        INT
) STRICT;

CREATE TABLE IF NOT EXISTS Service_Request (
    id          INT         PRIMARY KEY,
    type        TEXT        CHECK (type IN ('MAINTENANCE', 'FLOWERS')),
    notes       TEXT,
    location_id TEXT
) STRICT;

CREATE TABLE IF NOT EXISTS Maintenance_Request (
    request_id          INT     REFERENCES Service_Request(id),
    maintenance_type    TEXT    CHECK (maintenance_type IN ('PLUMBING', 'ELEVATOR')),
    workers_needed      INT,

    PRIMARY KEY (request_id)
) STRICT;

CREATE TABLE IF NOT EXISTS Flower_Request (
    request_id          INT     REFERENCES Service_Request(id),
    flower_type         TEXT    CHECK (flower_type IN ('ROSE', 'DANDELION')),
    number_flowers      INT,

    PRIMARY KEY (request_id)
) STRICT;


"""



