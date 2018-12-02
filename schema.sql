CREATE DATABASE IF NOT EXISTS TiNiuB;
USE TiNiuB;

CREATE TABLE IF NOT EXISTS `pd_store` (
        `id`                    BIGINT,
        `address`               VARCHAR(255),
        `state`                 VARCHAR(255),
        `version`               VARCHAR(255),
        `capacity`              BIGINT,
        `available`             BIGINT,
        `leader_count`          BIGINT,
        `region_count`          BIGINT,
        `is_busy`               INT,
        `start_ts`              VARCHAR(255),
        `last_heartbeat_ts`     VARCHAR(255),
        `uptime`                VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `pd_store_label` (
        `id`                    BIGINT,
        `label_key`             VARCHAR(255),
        `label_value`           VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `pd_region` (
        `id`                    BIGINT,
        `start_key`             VARCHAR(1024),
        `end_key`               VARCHAR(1024),
        `conf_ver`              BIGINT,
        `version`               BIGINT,
        `leader_peer_id`        BIGINT,
        `leader_store_id`       BIGINT,
        `written_bytes`         BIGINT,
        `read_bytes`            BIGINT,
        `approximate_size`      BIGINT,
        `approximate_keys`      BIGINT
);

CREATE TABLE IF NOT EXISTS `pd_region_peer` (
        `id`                    BIGINT,
        `region_id`             BIGINT,
        `store_id`              BIGINT,
        `is_leader`             INT,
        `is_down`               INT,
        `is_pending`            INT
);

CREATE TABLE IF NOT EXISTS `pd_config` (
        `module`                VARCHAR(255),
        `key`                   VARCHAR(255),
        `value`                 VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `service` (
        `instance`              VARCHAR(255),
        `type`                  VARCHAR(255),
        `name`                  VARCHAR(255),
        `port`                  INT,
        `log_file`              VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `memory` (
       `instance`               VARCHAR(255),
       `pid`                    BIGINT,
        `rss`                   BIGINT,
        `vms`                   BIGINT,
        `data`                  BIGINT,
        `stack`                 BIGINT,
        `locked`                BIGINT,
        `swap`                  BIGINT
);

CREATE TABLE IF NOT EXISTS `cpu` (
       `instance`              VARCHAR(255),
       `pid`                    BIGINT,
        `cpu`                   TEXT,
        `user`                  DOUBLE,
        `system`                DOUBLE,
        `idle`                  DOUBLE,
        `nice`                  DOUBLE,
        `iowait`                DOUBLE,
        `irq`                   DOUBLE,
        `softirq`               DOUBLE,
        `steal`                 DOUBLE,
        `guest`                 DOUBLE,
        `stolen`                DOUBLE
);

CREATE TABLE IF NOT EXISTS `acpi_tables` (`instance` TEXT,`name` TEXT, `size` INTEGER, `md5` TEXT);
CREATE TABLE IF NOT EXISTS `apt_sources` (`instance` TEXT,`name` TEXT, `source` TEXT, `base_uri` TEXT, `release` TEXT, `version` TEXT, `maintainer` TEXT, `components` TEXT, `architectures` TEXT);
CREATE TABLE IF NOT EXISTS `arp_cache` (`instance` TEXT,`address` TEXT, `mac` TEXT, `interface` TEXT, `permanent` TEXT);
CREATE TABLE IF NOT EXISTS `augeas` (`instance` TEXT,`node` TEXT, `value` TEXT, `label` TEXT, `path` TEXT);
CREATE TABLE IF NOT EXISTS `authorized_keys` (`instance` TEXT,`uid` BIGINT, `algorithm` TEXT, `key` TEXT, `key_file` TEXT)  ;
CREATE TABLE IF NOT EXISTS `block_devices` (`instance` TEXT,`name` TEXT, `parent` TEXT, `vendor` TEXT, `model` TEXT, `size` BIGINT, `block_size` INTEGER, `uuid` TEXT, `type` TEXT, `label` TEXT);
CREATE TABLE IF NOT EXISTS `carbon_black_info` (`instance` TEXT,`sensor_id` INTEGER, `config_name` TEXT, `collect_store_files` INTEGER, `collect_module_loads` INTEGER, `collect_module_info` INTEGER, `collect_file_mods` INTEGER, `collect_reg_mods` INTEGER, `collect_net_conns` INTEGER, `collect_processes` INTEGER, `collect_cross_processes` INTEGER, `collect_emet_events` INTEGER, `collect_data_file_writes` INTEGER, `collect_process_user_context` INTEGER, `collect_sensor_operations` INTEGER, `log_file_disk_quota_mb` INTEGER, `log_file_disk_quota_percentage` INTEGER, `protection_disabled` INTEGER, `sensor_ip_addr` TEXT, `sensor_backend_server` TEXT, `event_queue` INTEGER, `binary_queue` INTEGER);
CREATE TABLE IF NOT EXISTS `carves` (`instance` TEXT,`time` BIGINT, `sha256` TEXT, `size` INTEGER, `path` TEXT, `status` TEXT, `carve_guid` TEXT, `carve` INTEGER);
CREATE TABLE IF NOT EXISTS `chrome_extensions` (`instance` TEXT,`uid` BIGINT, `name` TEXT, `identifier` TEXT, `version` TEXT, `description` TEXT, `locale` TEXT, `update_url` TEXT, `author` TEXT, `persistent` INTEGER, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `cpu_time` (`instance` TEXT,`core` INTEGER, `user` BIGINT, `nice` BIGINT, `system` BIGINT, `idle` BIGINT, `iowait` BIGINT, `irq` BIGINT, `softirq` BIGINT, `steal` BIGINT, `guest` BIGINT, `guest_nice` BIGINT);
CREATE TABLE IF NOT EXISTS `cpuid` (`instance` TEXT,`feature` TEXT, `value` TEXT, `output_register` TEXT, `output_bit` INTEGER, `input_eax` TEXT);
CREATE TABLE IF NOT EXISTS `crontab` (`instance` TEXT,`event` TEXT, `minute` TEXT, `hour` TEXT, `day_of_month` TEXT, `month` TEXT, `day_of_week` TEXT, `command` TEXT, `path` TEXT);
CREATE TABLE IF NOT EXISTS `curl` (`instance` TEXT,`url` TEXT, `method` TEXT, `user_agent` TEXT, `response_code` INTEGER, `round_trip_time` BIGINT, `bytes` BIGINT, `result` TEXT)  ;
CREATE TABLE IF NOT EXISTS `curl_certificate` (`instance` TEXT,`hostname` TEXT, `common_name` TEXT, `organization` TEXT, `organization_unit` TEXT, `serial_number` TEXT, `issuer_common_name` TEXT, `issuer_organization` TEXT, `issuer_organization_unit` TEXT, `valid_from` TEXT, `valid_to` TEXT, `sha256_fingerprint` TEXT, `sha1_fingerprint` TEXT);
CREATE TABLE IF NOT EXISTS `deb_packages` (`instance` TEXT,`name` TEXT, `version` TEXT, `source` TEXT, `size` BIGINT, `arch` TEXT, `revision` TEXT);
CREATE TABLE IF NOT EXISTS `device_file` (`instance` TEXT,`device` TEXT, `partition` TEXT, `path` TEXT, `filename` TEXT, `inode` BIGINT, `uid` BIGINT, `gid` BIGINT, `mode` TEXT, `size` BIGINT, `block_size` INTEGER, `atime` BIGINT, `mtime` BIGINT, `ctime` BIGINT, `hard_links` INTEGER, `type` TEXT)  ;
CREATE TABLE IF NOT EXISTS `device_hash` (`instance` TEXT,`device` TEXT, `partition` TEXT, `inode` BIGINT, `md5` TEXT, `sha1` TEXT, `sha256` TEXT);
CREATE TABLE IF NOT EXISTS `device_partitions` (`instance` TEXT,`device` TEXT, `partition` INTEGER, `label` TEXT, `type` TEXT, `offset` BIGINT, `blocks_size` BIGINT, `blocks` BIGINT, `inodes` BIGINT, `flags` INTEGER);
CREATE TABLE IF NOT EXISTS `disk_encryption` (`instance` TEXT,`name` TEXT, `uuid` TEXT, `encrypted` INTEGER, `type` TEXT, `uid` TEXT, `user_uuid` TEXT, `encryption_status` TEXT);
CREATE TABLE IF NOT EXISTS `dns_resolvers` (`instance` TEXT,`id` INTEGER, `type` TEXT, `address` TEXT, `netmask` TEXT, `options` BIGINT);
CREATE TABLE IF NOT EXISTS `elf_dynamic` (`instance` TEXT, `tag` INTEGER, `value` INTEGER, `class` INTEGER, `path` TEXT);
CREATE TABLE IF NOT EXISTS `elf_info` (`instance` TEXT,`class` TEXT, `abi` TEXT, `abi_version` INTEGER, `type` TEXT, `machine` INTEGER, `version` INTEGER, `entry` BIGINT, `flags` INTEGER, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `elf_sections` (`instance` TEXT,`name` TEXT, `type` INTEGER, `vaddr` INTEGER, `offset` INTEGER, `size` INTEGER, `flags` TEXT, `link` TEXT, `align` INTEGER, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `elf_segments` (`instance` TEXT,`name` TEXT, `offset` INTEGER, `vaddr` INTEGER, `psize` INTEGER, `msize` INTEGER, `flags` TEXT, `align` INTEGER, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `elf_symbols` (`instance` TEXT,`name` TEXT, `addr` INTEGER, `size` INTEGER, `type` TEXT, `binding` TEXT, `offset` INTEGER, `table` TEXT, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `etc_hosts` (`instance` TEXT,`address` TEXT, `hostnames` TEXT);
CREATE TABLE IF NOT EXISTS `etc_protocols` (`instance` TEXT,`name` TEXT, `number` INTEGER, `alias` TEXT, `comment` TEXT);
CREATE TABLE IF NOT EXISTS `etc_services` (`instance` TEXT,`name` TEXT, `port` INTEGER, `protocol` TEXT, `aliases` TEXT, `comment` TEXT);
CREATE TABLE IF NOT EXISTS `file_events` (`instance` TEXT,`target_path` TEXT, `category` TEXT, `action` TEXT, `transaction_id` BIGINT, `inode` BIGINT, `uid` BIGINT, `gid` BIGINT, `mode` TEXT, `size` BIGINT, `atime` BIGINT, `mtime` BIGINT, `ctime` BIGINT, `md5` TEXT, `sha1` TEXT, `sha256` TEXT, `hashed` INTEGER, `time` BIGINT);
CREATE TABLE IF NOT EXISTS `firefox_addons` (`instance` TEXT,`uid` BIGINT, `name` TEXT, `identifier` TEXT, `creator` TEXT, `type` TEXT, `version` TEXT, `description` TEXT, `source_url` TEXT, `visible` INTEGER, `active` INTEGER, `disabled` INTEGER, `autoupdate` INTEGER, `native` INTEGER, `location` TEXT, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `groups` (`instance` TEXT,`gid` BIGINT, `gid_signed` BIGINT, `groupname` TEXT)  ;
CREATE TABLE IF NOT EXISTS `hardware_events` (`instance` TEXT,`action` TEXT, `path` TEXT, `type` TEXT, `driver` TEXT, `vendor` TEXT, `vendor_id` TEXT, `model` TEXT, `model_id` TEXT, `serial` TEXT, `revision` TEXT, `time` BIGINT);
CREATE TABLE IF NOT EXISTS `hash` (`instance` TEXT,`path` TEXT, `directory` TEXT, `md5` TEXT, `sha1` TEXT, `sha256` TEXT, `ssdeep` TEXT)  ;
CREATE TABLE IF NOT EXISTS `intel_me_info` (`instance` TEXT,`version` TEXT);
CREATE TABLE IF NOT EXISTS `interface_addresses` (`instance` TEXT,`interface` TEXT, `address` TEXT, `mask` TEXT, `broadcast` TEXT, `point_to_point` TEXT, `type` TEXT);
CREATE TABLE IF NOT EXISTS `interface_details` (`instance` TEXT,`interface` TEXT, `mac` TEXT, `type` INTEGER, `mtu` INTEGER, `metric` INTEGER, `flags` INTEGER, `ipackets` BIGINT, `opackets` BIGINT, `ibytes` BIGINT, `obytes` BIGINT, `ierrors` BIGINT, `oerrors` BIGINT, `idrops` BIGINT, `odrops` BIGINT, `collisions` BIGINT, `last_change` BIGINT, `link_speed` BIGINT, `pci_slot` TEXT);
CREATE TABLE IF NOT EXISTS `iptables` (`instance` TEXT,`filter_name` TEXT, `chain` TEXT, `policy` TEXT, `target` TEXT, `protocol` INTEGER, `src_port` TEXT, `dst_port` TEXT, `src_ip` TEXT, `src_mask` TEXT, `iniface` TEXT, `iniface_mask` TEXT, `dst_ip` TEXT, `dst_mask` TEXT, `outiface` TEXT, `outiface_mask` TEXT, `match` TEXT, `packets` INTEGER, `bytes` INTEGER);
CREATE TABLE IF NOT EXISTS `kernel_info` (`instance` TEXT,`version` TEXT, `arguments` TEXT, `path` TEXT, `device` TEXT);
CREATE TABLE IF NOT EXISTS `kernel_integrity` (`instance` TEXT,`sycall_addr_modified` INTEGER, `text_segment_hash` TEXT);
CREATE TABLE IF NOT EXISTS `kernel_modules` (`instance` TEXT,`name` TEXT, `size` TEXT, `used_by` TEXT, `status` TEXT, `address` TEXT);
CREATE TABLE IF NOT EXISTS `known_hosts` (`instance` TEXT,`uid` BIGINT, `key` TEXT, `key_file` TEXT)  ;
CREATE TABLE IF NOT EXISTS `last` (`instance` TEXT,`username` TEXT, `tty` TEXT, `pid` INTEGER, `type` INTEGER, `time` INTEGER, `host` TEXT);
CREATE TABLE IF NOT EXISTS `listening_ports` (`instance` TEXT,`pid` INTEGER, `port` INTEGER, `protocol` INTEGER, `family` INTEGER, `address` TEXT, `fd` BIGINT, `socket` BIGINT, `path` TEXT, `net_namespace` TEXT);
CREATE TABLE IF NOT EXISTS `lldp_neighbors` (`instance` TEXT,`interface` TEXT, `rid` INTEGER, `chassis_id_type` TEXT, `chassis_id` TEXT, `chassis_sysname` TEXT, `chassis_sys_description` INTEGER, `chassis_bridge_capability_available` INTEGER, `chassis_bridge_capability_enabled` INTEGER, `chassis_router_capability_available` INTEGER, `chassis_router_capability_enabled` INTEGER, `chassis_repeater_capability_available` INTEGER, `chassis_repeater_capability_enabled` INTEGER, `chassis_wlan_capability_available` INTEGER, `chassis_wlan_capability_enabled` INTEGER, `chassis_tel_capability_available` INTEGER, `chassis_tel_capability_enabled` INTEGER, `chassis_docsis_capability_available` INTEGER, `chassis_docsis_capability_enabled` INTEGER, `chassis_station_capability_available` INTEGER, `chassis_station_capability_enabled` INTEGER, `chassis_other_capability_available` INTEGER, `chassis_other_capability_enabled` INTEGER, `chassis_mgmt_ips` TEXT, `port_id_type` TEXT, `port_id` TEXT, `port_description` TEXT, `port_ttl` BIGINT, `port_mfs` BIGINT, `port_aggregation_id` TEXT, `port_autoneg_supported` INTEGER, `port_autoneg_enabled` INTEGER, `port_mau_type` TEXT, `port_autoneg_10baset_hd_enabled` INTEGER, `port_autoneg_10baset_fd_enabled` INTEGER, `port_autoneg_100basetx_hd_enabled` INTEGER, `port_autoneg_100basetx_fd_enabled` INTEGER, `port_autoneg_100baset2_hd_enabled` INTEGER, `port_autoneg_100baset2_fd_enabled` INTEGER, `port_autoneg_100baset4_hd_enabled` INTEGER, `port_autoneg_100baset4_fd_enabled` INTEGER, `port_autoneg_1000basex_hd_enabled` INTEGER, `port_autoneg_1000basex_fd_enabled` INTEGER, `port_autoneg_1000baset_hd_enabled` INTEGER, `port_autoneg_1000baset_fd_enabled` INTEGER, `power_device_type` TEXT, `power_mdi_supported` INTEGER, `power_mdi_enabled` INTEGER, `power_paircontrol_enabled` INTEGER, `power_pairs` TEXT, `power_class` TEXT, `power_8023at_enabled` INTEGER, `power_8023at_power_type` TEXT, `power_8023at_power_source` TEXT, `power_8023at_power_priority` TEXT, `power_8023at_power_allocated` TEXT, `power_8023at_power_requested` TEXT, `med_device_type` TEXT, `med_capability_capabilities` INTEGER, `med_capability_policy` INTEGER, `med_capability_location` INTEGER, `med_capability_mdi_pse` INTEGER, `med_capability_mdi_pd` INTEGER, `med_capability_inventory` INTEGER, `med_policies` TEXT, `vlans` TEXT, `pvid` TEXT, `ppvids_supported` TEXT, `ppvids_enabled` TEXT, `pids` TEXT);
CREATE TABLE IF NOT EXISTS `load_average` (`instance` TEXT,`period` TEXT, `average` TEXT);
CREATE TABLE IF NOT EXISTS `logged_in_users` (`instance` TEXT,`type` TEXT, `user` TEXT, `tty` TEXT, `host` TEXT, `time` INTEGER, `pid` INTEGER);
CREATE TABLE IF NOT EXISTS `magic` (`instance` TEXT,`path` TEXT, `data` TEXT, `mime_type` TEXT, `mime_encoding` TEXT);
CREATE TABLE IF NOT EXISTS `md_devices` (`instance` TEXT,`device_name` TEXT, `status` TEXT, `raid_level` INTEGER, `size` BIGINT, `chunk_size` BIGINT, `raid_disks` INTEGER, `nr_raid_disks` INTEGER, `working_disks` INTEGER, `active_disks` INTEGER, `failed_disks` INTEGER, `spare_disks` INTEGER, `superblock_state` TEXT, `superblock_version` TEXT, `superblock_update_time` BIGINT, `bitmap_on_mem` TEXT, `bitmap_chunk_size` TEXT, `bitmap_external_file` TEXT, `recovery_progress` TEXT, `recovery_finish` TEXT, `recovery_speed` TEXT, `resync_progress` TEXT, `resync_finish` TEXT, `resync_speed` TEXT, `reshape_progress` TEXT, `reshape_finish` TEXT, `reshape_speed` TEXT, `check_array_progress` TEXT, `check_array_finish` TEXT, `check_array_speed` TEXT, `unused_devices` TEXT, `other` TEXT);
CREATE TABLE IF NOT EXISTS `md_drives` (`instance` TEXT,`md_device_name` TEXT, `drive_name` TEXT, `slot` INTEGER, `state` TEXT);
CREATE TABLE IF NOT EXISTS `md_personalities` (`instance` TEXT,`name` TEXT);
CREATE TABLE IF NOT EXISTS `memory_array_mapped_addresses` (`instance` TEXT,`handle` TEXT, `memory_array_handle` TEXT, `starting_address` TEXT, `ending_address` TEXT, `partition_width` INTEGER);
CREATE TABLE IF NOT EXISTS `memory_arrays` (`instance` TEXT,`handle` TEXT, `location` TEXT, `use` TEXT, `memory_error_correction` TEXT, `max_capacity` INTEGER, `memory_error_info_handle` TEXT, `number_memory_devices` INTEGER);
CREATE TABLE IF NOT EXISTS `memory_device_mapped_addresses` (`instance` TEXT,`handle` TEXT, `memory_device_handle` TEXT, `memory_array_mapped_address_handle` TEXT, `starting_address` TEXT, `ending_address` TEXT, `partition_row_position` INTEGER, `interleave_position` INTEGER, `interleave_data_depth` INTEGER);
CREATE TABLE IF NOT EXISTS `memory_devices` (`instance` TEXT,`handle` TEXT, `array_handle` TEXT, `form_factor` TEXT, `total_width` INTEGER, `data_width` INTEGER, `size` INTEGER, `set` INTEGER, `device_locator` TEXT, `bank_locator` TEXT, `memory_type` TEXT, `memory_type_details` TEXT, `max_speed` INTEGER, `configured_clock_speed` INTEGER, `manufacturer` TEXT, `serial_number` TEXT, `asset_tag` TEXT, `part_number` TEXT, `min_voltage` INTEGER, `max_voltage` INTEGER, `configured_voltage` INTEGER);
CREATE TABLE IF NOT EXISTS `memory_error_info` (`instance` TEXT,`handle` TEXT, `error_type` TEXT, `error_granularity` TEXT, `error_operation` TEXT, `vendor_syndrome` TEXT, `memory_array_error_address` TEXT, `device_error_address` TEXT, `error_resolution` TEXT);
CREATE TABLE IF NOT EXISTS `memory_info` (`instance` TEXT,`memory_total` BIGINT, `memory_free` BIGINT, `buffers` BIGINT, `cached` BIGINT, `swap_cached` BIGINT, `active` BIGINT, `inactive` BIGINT, `swap_total` BIGINT, `swap_free` BIGINT);
CREATE TABLE IF NOT EXISTS `memory_map` (`instance` TEXT,`name` TEXT, `start` TEXT, `end` TEXT);
CREATE TABLE IF NOT EXISTS `mounts` (`instance` TEXT,`device` TEXT, `device_alias` TEXT, `path` TEXT, `type` TEXT, `blocks_size` BIGINT, `blocks` BIGINT, `blocks_free` BIGINT, `blocks_available` BIGINT, `inodes` BIGINT, `inodes_free` BIGINT, `flags` TEXT);
CREATE TABLE IF NOT EXISTS `msr` (`instance` TEXT,`processor_number` BIGINT, `turbo_disabled` BIGINT, `turbo_ratio_limit` BIGINT, `platform_info` BIGINT, `perf_ctl` BIGINT, `perf_status` BIGINT, `feature_control` BIGINT, `rapl_power_limit` BIGINT, `rapl_energy_status` BIGINT, `rapl_power_units` BIGINT);
CREATE TABLE IF NOT EXISTS `npm_packages` (`instance` TEXT,`name` TEXT, `version` TEXT, `description` TEXT, `author` TEXT, `license` TEXT, `path` TEXT, `directory` TEXT);
CREATE TABLE IF NOT EXISTS `opera_extensions` (`instance` TEXT,`uid` BIGINT, `name` TEXT, `identifier` TEXT, `version` TEXT, `description` TEXT, `locale` TEXT, `update_url` TEXT, `author` TEXT, `persistent` INTEGER, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `os_version` (`instance` TEXT,`name` TEXT, `version` TEXT, `major` INTEGER, `minor` INTEGER, `patch` INTEGER, `build` TEXT, `platform` TEXT, `platform_like` TEXT, `codename` TEXT);
CREATE TABLE IF NOT EXISTS `osquery_events` (`instance` TEXT,`name` TEXT, `publisher` TEXT, `type` TEXT, `subscriptions` INTEGER, `events` INTEGER, `refreshes` INTEGER, `active` INTEGER);
CREATE TABLE IF NOT EXISTS `osquery_extensions` (`instance` TEXT,`uuid` BIGINT, `name` TEXT, `version` TEXT, `sdk_version` TEXT, `path` TEXT, `type` TEXT);
CREATE TABLE IF NOT EXISTS `osquery_flags` (`instance` TEXT,`name` TEXT, `type` TEXT, `description` TEXT, `default_value` TEXT, `value` TEXT, `shell_only` INTEGER);
CREATE TABLE IF NOT EXISTS `osquery_info` (`instance` TEXT,`pid` INTEGER, `uuid` TEXT, `instance_id` TEXT, `version` TEXT, `config_hash` TEXT, `config_valid` INTEGER, `extensions` TEXT, `build_platform` TEXT, `build_distro` TEXT, `start_time` INTEGER, `watcher` INTEGER);
CREATE TABLE IF NOT EXISTS `osquery_packs` (`instance` TEXT,`name` TEXT, `platform` TEXT, `version` TEXT, `shard` INTEGER, `discovery_cache_hits` INTEGER, `discovery_executions` INTEGER, `active` INTEGER);
CREATE TABLE IF NOT EXISTS `osquery_registry` (`instance` TEXT,`registry` TEXT, `name` TEXT, `owner_uuid` INTEGER, `internal` INTEGER, `active` INTEGER);
CREATE TABLE IF NOT EXISTS `osquery_schedule` (`instance` TEXT,`name` TEXT, `query` TEXT, `interval` INTEGER, `executions` BIGINT, `last_executed` BIGINT, `blacklisted` INTEGER, `output_size` BIGINT, `wall_time` BIGINT, `user_time` BIGINT, `system_time` BIGINT, `average_memory` BIGINT);
CREATE TABLE IF NOT EXISTS `pci_devices` (`instance` TEXT,`pci_slot` TEXT, `pci_class` TEXT, `driver` TEXT, `vendor` TEXT, `vendor_id` TEXT, `model` TEXT, `model_id` TEXT);
CREATE TABLE IF NOT EXISTS `platform_info` (`instance` TEXT,`vendor` TEXT, `version` TEXT, `date` TEXT, `revision` TEXT, `address` TEXT, `size` TEXT, `volume_size` INTEGER, `extra` TEXT);
CREATE TABLE IF NOT EXISTS `portage_keywords` (`instance` TEXT,`package` TEXT, `version` TEXT, `keyword` TEXT, `mask` INTEGER, `unmask` INTEGER);
CREATE TABLE IF NOT EXISTS `portage_packages` (`instance` TEXT,`package` TEXT, `version` TEXT, `slot` TEXT, `build_time` BIGINT, `repository` TEXT, `eapi` BIGINT, `size` BIGINT, `world` INTEGER);
CREATE TABLE IF NOT EXISTS `portage_use` (`instance` TEXT,`package` TEXT, `version` TEXT, `use` TEXT);
CREATE TABLE IF NOT EXISTS `process_envs` (`instance` TEXT,`pid` INTEGER, `key` TEXT, `value` TEXT)  ;
CREATE TABLE IF NOT EXISTS `process_events` (`instance` TEXT,`pid` BIGINT, `path` TEXT, `mode` TEXT, `cmdline` TEXT,  `cwd` TEXT, `auid` BIGINT, `uid` BIGINT, `euid` BIGINT, `gid` BIGINT, `egid` BIGINT, `owner_uid` BIGINT, `owner_gid` BIGINT, `atime` BIGINT, `mtime` BIGINT, `ctime` BIGINT, `btime` BIGINT,  `parent` BIGINT, `time` BIGINT, `uptime` BIGINT);
CREATE TABLE IF NOT EXISTS `process_file_events` (`instance` TEXT,`operation` TEXT, `pid` BIGINT, `ppid` BIGINT, `time` BIGINT, `executable` TEXT, `partial` TEXT, `cwd` TEXT, `path` TEXT, `dest_path` TEXT, `uid` TEXT, `gid` TEXT, `euid` TEXT, `egid` TEXT, `uptime` BIGINT);
CREATE TABLE IF NOT EXISTS `process_memory_map` (`instance` TEXT,`pid` INTEGER, `start` TEXT, `end` TEXT, `permissions` TEXT, `offset` BIGINT, `device` TEXT, `inode` INTEGER, `path` TEXT, `pseudo` INTEGER)  ;
CREATE TABLE IF NOT EXISTS `process_namespaces` (`instance` TEXT,`pid` INTEGER, `cgroup_namespace` TEXT, `ipc_namespace` TEXT, `mnt_namespace` TEXT, `net_namespace` TEXT, `pid_namespace` TEXT, `user_namespace` TEXT, `uts_namespace` TEXT)  ;
CREATE TABLE IF NOT EXISTS `process_open_files` (`instance` TEXT,`pid` BIGINT, `fd` BIGINT, `path` TEXT)  ;
CREATE TABLE IF NOT EXISTS `process_open_sockets` (`instance` TEXT,`pid` INTEGER, `fd` BIGINT, `socket` BIGINT, `family` INTEGER, `protocol` INTEGER, `local_address` TEXT, `remote_address` TEXT, `local_port` INTEGER, `remote_port` INTEGER, `path` TEXT, `state` TEXT, `net_namespace` TEXT)  ;
CREATE TABLE IF NOT EXISTS `processes` (`instance` TEXT,`pid` BIGINT, `name` TEXT, `path` TEXT, `cmdline` TEXT, `state` TEXT, `cwd` TEXT, `root` TEXT, `uid` BIGINT, `gid` BIGINT, `euid` BIGINT, `egid` BIGINT, `suid` BIGINT, `sgid` BIGINT, `on_disk` INTEGER, `wired_size` BIGINT, `resident_size` BIGINT, `total_size` BIGINT, `user_time` BIGINT, `system_time` BIGINT, `disk_bytes_read` BIGINT, `disk_bytes_written` BIGINT, `start_time` BIGINT, `parent` BIGINT, `pgroup` BIGINT, `threads` INTEGER, `nice` INTEGER)  ;
CREATE TABLE IF NOT EXISTS `prometheus_metrics` (`instance` TEXT,`target_name` TEXT, `metric_name` TEXT, `metric_value` DOUBLE, `timestamp_ms` BIGINT);
CREATE TABLE IF NOT EXISTS `python_packages` (`instance` TEXT,`name` TEXT, `version` TEXT, `summary` TEXT, `author` TEXT, `license` TEXT, `path` TEXT, `directory` TEXT);
CREATE TABLE IF NOT EXISTS `routes` (`instance` TEXT,`destination` TEXT, `netmask` TEXT, `gateway` TEXT, `source` TEXT, `flags` INTEGER, `interface` TEXT, `mtu` INTEGER, `metric` INTEGER, `type` TEXT);
CREATE TABLE IF NOT EXISTS `selinux_events` (`instance` TEXT,`type` TEXT, `message` TEXT, `time` BIGINT, `uptime` BIGINT);
CREATE TABLE IF NOT EXISTS `shadow` (`instance` TEXT,`password_status` TEXT, `hash_alg` TEXT, `last_change` BIGINT, `min` BIGINT, `max` BIGINT, `warning` BIGINT, `inactive` BIGINT, `expire` BIGINT, `flag` BIGINT, `username` TEXT)  ;
CREATE TABLE IF NOT EXISTS `shared_memory` (`instance` TEXT,`shmid` INTEGER, `owner_uid` BIGINT, `creator_uid` BIGINT, `pid` BIGINT, `creator_pid` BIGINT, `atime` BIGINT, `dtime` BIGINT, `ctime` BIGINT, `permissions` TEXT, `size` BIGINT, `attached` INTEGER, `status` TEXT, `locked` INTEGER);
CREATE TABLE IF NOT EXISTS `shell_history` (`instance` TEXT,`uid` BIGINT, `time` INTEGER, `command` TEXT, `history_file` TEXT);
CREATE TABLE IF NOT EXISTS `smart_drive_info` (`instance` TEXT,`device_name` TEXT, `disk_id` INTEGER, `driver_type` TEXT, `model_family` TEXT, `device_model` TEXT, `serial_number` TEXT, `lu_wwn_device_id` TEXT, `additional_product_id` TEXT, `firmware_version` TEXT, `user_capacity` TEXT, `sector_sizes` TEXT, `rotation_rate` TEXT, `form_factor` TEXT, `in_smartctl_db` INTEGER, `ata_version` TEXT, `transport_type` TEXT, `sata_version` TEXT, `read_device_identity_failure` TEXT, `smart_supported` TEXT, `smart_enabled` TEXT, `packet_device_type` TEXT, `power_mode` TEXT, `warnings` TEXT)  ;
CREATE TABLE IF NOT EXISTS `smbios_tables` (`instance` TEXT,`number` INTEGER, `type` INTEGER, `description` TEXT, `handle` INTEGER, `header_size` INTEGER, `size` INTEGER, `md5` TEXT);
CREATE TABLE IF NOT EXISTS `socket_events` (`instance` TEXT,`action` TEXT, `pid` BIGINT, `path` TEXT, `fd` TEXT, `auid` BIGINT, `success` INTEGER, `family` INTEGER, `local_address` TEXT, `remote_address` TEXT, `local_port` INTEGER, `remote_port` INTEGER, `time` BIGINT, `uptime` BIGINT);
CREATE TABLE IF NOT EXISTS `ssh_configs` (`instance` TEXT,`uid` BIGINT, `block` TEXT, `option` TEXT, `ssh_config_file` TEXT)  ;
CREATE TABLE IF NOT EXISTS `sudoers` (`instance` TEXT,`header` TEXT, `rule_details` TEXT);
CREATE TABLE IF NOT EXISTS `suid_bin` (`instance` TEXT,`path` TEXT, `username` TEXT, `groupname` TEXT, `permissions` TEXT);
CREATE TABLE IF NOT EXISTS `syslog_events` (`instance` TEXT,`time` BIGINT, `datetime` TEXT, `host` TEXT, `severity` INTEGER, `facility` TEXT, `tag` TEXT, `message` TEXT);
CREATE TABLE IF NOT EXISTS `system_controls` (`instance` TEXT,`name` TEXT, `oid` TEXT, `subsystem` TEXT, `current_value` TEXT, `config_value` TEXT, `type` TEXT)  ;
CREATE TABLE IF NOT EXISTS `system_info` (`instance` TEXT,`hostname` TEXT, `uuid` TEXT, `cpu_type` TEXT, `cpu_subtype` TEXT, `cpu_brand` TEXT, `cpu_physical_cores` INTEGER, `cpu_logical_cores` INTEGER, `cpu_microcode` TEXT, `physical_memory` BIGINT, `hardware_vendor` TEXT, `hardware_model` TEXT, `hardware_version` TEXT, `hardware_serial` TEXT, `computer_name` TEXT, `local_hostname` TEXT);
CREATE TABLE IF NOT EXISTS `time` (`instance` TEXT,`weekday` TEXT, `year` INTEGER, `month` INTEGER, `day` INTEGER, `hour` INTEGER, `minutes` INTEGER, `seconds` INTEGER, `timezone` TEXT, `local_time` INTEGER, `local_timezone` TEXT, `unix_time` INTEGER, `timestamp` TEXT, `datetime` TEXT, `iso_8601` TEXT);
CREATE TABLE IF NOT EXISTS `ulimit_info` (`instance` TEXT,`type` TEXT, `soft_limit` TEXT, `hard_limit` TEXT);
CREATE TABLE IF NOT EXISTS `uptime` (`instance` TEXT,`days` INTEGER, `hours` INTEGER, `minutes` INTEGER, `seconds` INTEGER, `total_seconds` BIGINT);
CREATE TABLE IF NOT EXISTS `usb_devices` (`instance` TEXT,`usb_address` INTEGER, `usb_port` INTEGER, `vendor` TEXT, `vendor_id` TEXT, `version` TEXT, `model` TEXT, `model_id` TEXT, `serial` TEXT, `class` TEXT, `subclass` TEXT, `protocol` TEXT, `removable` INTEGER);
CREATE TABLE IF NOT EXISTS `user_events` (`instance` TEXT,`uid` BIGINT, `auid` BIGINT, `pid` BIGINT, `message` TEXT, `type` INTEGER, `path` TEXT, `address` TEXT, `terminal` TEXT, `time` BIGINT, `uptime` BIGINT);
CREATE TABLE IF NOT EXISTS `user_groups` (`instance` TEXT,`uid` BIGINT, `gid` BIGINT)  ;
CREATE TABLE IF NOT EXISTS `user_ssh_keys` (`instance` TEXT,`uid` BIGINT, `path` TEXT, `encrypted` INTEGER)  ;
CREATE TABLE IF NOT EXISTS `users` (`instance` TEXT,`uid` BIGINT, `gid` BIGINT, `uid_signed` BIGINT, `gid_signed` BIGINT, `username` TEXT, `description` TEXT, `directory` TEXT, `shell` TEXT, `uuid` TEXT)  ;
CREATE TABLE IF NOT EXISTS `yara` (`instance` TEXT,`path` TEXT, `matches` TEXT, `count` INTEGER, `sig_group` TEXT, `sigfile` TEXT, `strings` TEXT, `tags` TEXT)  ;
CREATE TABLE IF NOT EXISTS `yara_events` (`instance` TEXT,`target_path` TEXT, `category` TEXT, `action` TEXT, `transaction_id` BIGINT, `matches` TEXT, `count` INTEGER, `strings` TEXT, `tags` TEXT, `time` BIGINT);
CREATE TABLE IF NOT EXISTS `yum_sources` (`instance` TEXT,`name` TEXT, `baseurl` TEXT, `enabled` TEXT, `gpgcheck` TEXT, `gpgkey` TEXT);

