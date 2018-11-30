CREATE TABLE `pd_stores` IF NOT EXISTS (
        `id` BIGINT,
        `address` VARCHAR(32),
        `state` VARCHAR(32),
        `version` VARCHAR(32),
        `capacity` BIGINT,
        `available` BIGINT,
        `leader_count` BIGINT,
        `region_count` BIGINT,
        `is_busy` INT,
        `start_ts` VARCHAR(32),
        `last_heartbeat_ts` VARCHAR(32),
        `uptime` VARCHAR(32),
);