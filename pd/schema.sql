CREATE TABLE IF NOT EXISTS `pd_stores` (
        `id` BIGINT,
        `address` VARCHAR(255),
        `state` VARCHAR(255),
        `version` VARCHAR(255),
        `capacity` BIGINT,
        `available` BIGINT,
        `leader_count` BIGINT,
        `region_count` BIGINT,
        `is_busy` INT,
        `start_ts` VARCHAR(255),
        `last_heartbeat_ts` VARCHAR(255),
        `uptime` VARCHAR(255)
);