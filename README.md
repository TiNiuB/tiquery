# tiquery: all diagnosis in SQL
A TiDB hackathon2018 project

![TiNiuB](media/tiniub.png)

## What is tiquery used for?

`tiquery` integrates the various information of a TiDB cluster into the form of tables. You can use the standardized SQL language to query almost everything you need to diagnose the cluster, including:

- Topology of all components in the cluster
- Region metas and states
- Configurations
- CPU/Memory usage of a component
- Device information / OS information / network configuration / file system of all nodes
- process information / TCP connection / listening port in the cluster
- any many more...

## Show cases

### Show topology of all components

```
[TiNiuB] select * from service order by name;
+--------------+---------+---------+-------+---------------------------+
| instance     | type    | name    | port  | log_file                  |
+--------------+---------+---------+-------+---------------------------+
| 10-9-149-177 | pd      | pd1     |  2379 | /data/deploy/log/pd.log   |
| 10-9-84-81   | pd      | pd2     |  2379 | /data/deploy/log/pd.log   |
| 10-9-91-62   | pd      | pd3     |  2379 | /data/deploy/log/pd.log   |
| 10-9-149-177 | tidb    | tidb1   |  4000 | /data/deploy/log/tidb.log |
| 10-9-84-81   | tidb    | tidb2   |  4000 | /data/deploy/log/tidb.log |
| 10-9-91-62   | tikv    | tikv1   | 20160 | /data/deploy/log/tikv.log |
| 10-9-72-131  | tikv    | tikv2   | 20160 | /data/deploy/log/tikv.log |
| 10-9-43-249  | tikv    | tikv3   | 20160 | /data/deploy/log/tikv.log |
| 10-9-103-19  | tiquery | tiquery |  8080 |                           |
+--------------+---------+---------+-------+---------------------------+
9 rows in set (0.01 sec)

```

### Show region information
```
[TiNiuB] select * from pd_region limit 5;
+------+--------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+----------+---------+----------------+-----------------+---------------+------------+------------------+------------------+
| id   | start_key                                                                                  | end_key                                                                                    | conf_ver | version | leader_peer_id | leader_store_id | written_bytes | read_bytes | approximate_size | approximate_keys |
+------+--------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+----------+---------+----------------+-----------------+---------------+------------+------------------+------------------+
|  412 | 7480000000000000FFEB00000000000000F8                                                       | 7480000000000000FFED00000000000000F8                                                       |        5 |     103 |            415 |               5 |             0 |          0 |                6 |            40960 |
|  616 | 7480000000000001FF3E5F698000000000FF0000010400000000FF0007B1BF03800000FF0000099C56000000FC | 7480000000000001FF3E5F728000000000FF033B050000000000FA                                     |        5 |     154 |            619 |               5 |            39 |          6 |              104 |           639182 |
|  640 | 7480000000000001FF445F698000000000FF0000010400000000FF0007B1F503800000FF0000024FDB000000FC | 7480000000000001FF445F728000000000FF033F440000000000FA                                     |        5 |     159 |            643 |               5 |       3019300 |   17659602 |               94 |           552483 |
|  748 | 7480000000000001FF3200000000000000F8                                                       | 7480000000000001FF325F698000000000FF0000010400000000FF0007B1DB03800000FF00000A771E000000FC |        5 |     143 |            751 |               5 |       3576308 |          0 |               89 |          1164230 |
|   44 | 7480000000000000FF2F00000000000000F8                                                       | 7480000000000000FF3300000000000000F8                                                       |        5 |      13 |             46 |               4 |             0 |          0 |                6 |            40960 |
+------+--------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+----------+---------+----------------+-----------------+---------------+------------+------------------+------------------+
5 rows in set (0.02 sec)

```

### Show system information
```
[TiNiuB] select v.instance,v.name,s.physical_memory,s.cpu_physical_cores,s.cpu_logical_cores,k.version as kernel_version,o.version as os_version from service v,system_info s, kernel_info k,os_version o  where v.instance=s.instance and v.instance=k.instance and v.instance=o.instance;
+--------------+---------+-----------------+--------------------+-------------------+---------------------------+--------------------------------------+
| instance     | name    | physical_memory | cpu_physical_cores | cpu_logical_cores | kernel_version            | os_version                           |
+--------------+---------+-----------------+--------------------+-------------------+---------------------------+--------------------------------------+
| 10-9-84-81   | tidb2   |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-84-81   | pd2     |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-149-177 | tidb1   |     33566031872 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-149-177 | pd1     |     33566031872 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-72-131  | tikv2   |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-43-249  | tikv3   |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-91-62   | pd3     |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-91-62   | tikv1   |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
| 10-9-103-19  | tiquery |     33566040064 |                 16 |                16 | 3.10.0-862.9.1.el7.x86_64 | CentOS Linux release 7.2.1511 (Core) |
+--------------+---------+-----------------+--------------------+-------------------+---------------------------+--------------------------------------+
9 rows in set (0.26 sec)
```

### Show load of all TiKV nodes
```
[TiNiuB] select service.name, L.average, service.instance,service.port from load_average as L, service where L.period = '1m' and service.instance = L.instance and service.type like 'tikv%' order by L.average desc;
+-------+----------+-------------+-------+
| name  | average  | instance    | port  |
+-------+----------+-------------+-------+
| tikv1 | 0.060000 | 10-9-91-62  | 20160 |
| tikv2 | 0.060000 | 10-9-72-131 | 20160 |
| tikv3 | 0.060000 | 10-9-43-249 | 20160 |
+-------+----------+-------------+-------+
3 rows in set (0.19 sec)
```

### Show schedule configuration
```
[TiNiuB] select * from pd_config where module = 'schedule';
+----------+---------------------------------+--------+
| module   | key                             | value  |
+----------+---------------------------------+--------+
| schedule | max_snapshot_count              | 3      |
| schedule | max_pending_peer_count          | 16     |
| schedule | max_merge_region_size           | 20     |
| schedule | max_merge_region_keys           | 200000 |
| schedule | split_merge_interval            | 1h0m0s |
| schedule | patrol_region_interval          | 100ms  |
| schedule | max_store_down_time             | 30m0s  |
| schedule | leader_schedule_limit           | 4      |
| schedule | region_schedule_limit           | 4      |
| schedule | replica_schedule_limit          | 8      |
| schedule | merge_schedule_limit            | 8      |
| schedule | tolerant_size_ratio             | 5      |
| schedule | low_space_ratio                 | 0.8    |
| schedule | high_space_ratio                | 0.6    |
| schedule | disable_raft_learner            | false  |
| schedule | disable_remove_down_replica     | false  |
| schedule | disable_replace_offline_replica | false  |
| schedule | disable_make_up_replica         | false  |
| schedule | disable_remove_extra_replica    | false  |
| schedule | disable_location_replacement    | false  |
| schedule | disable_namespace_relocation    | false  |
+----------+---------------------------------+--------+
21 rows in set (0.00 sec)
```

## Setup guide

1. Build and run `tiquery` anywhere in the cluster.
2. Replace tidb-server in the cluster with `github.com/TiNiuB/tidb`. You can also add a new tidb-server to the cluster.
3. Update config file of tidb. In the `global` section, add line `tiniub = "http://{tiquery-ip}:8080"`.
4. Deploy `tiquery-agent` to nodes that need to trace.
5. `mysql -uroot -h{tidb-ip} -P 4000 < "schema.sql"` 
6. `mysql> use TiNiuB`
7. You are ready to go.