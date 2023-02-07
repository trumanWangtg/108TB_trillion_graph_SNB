![TG_LOGO](https://github.com/trumanWangtg/108TB_trillion_graph_SNB/blob/main/TigerGraph-Logo.png)

# TigerGraph 108 TB Soical Network Graph Implementations

This social network graph loads 108Tb raw data, and contains 217 billion vertices and 1.6 trillion edges/relationships. The 108TB data are inflated based on LDBC SNB official SF-30000 dataset. The LDBC SNB schema and BI workload queries were modified to ensure that most queries can activate the whole 108TB dataset.

 This experiment was carried out on AWS EC2 72 x r6a.48xlarge instances and not using any containerization/virtualization technology.  Full Disclosure Report of the [108T Social Network Benchmark](https://docs.google.com/document/d/1h4PnZGpg8-HYBvIHjjgdeonchZo7hSHfEK8IsTrTZN0/edit). (document to be replaced) 



To get started with LDBC SNB benchmarks, check out the introductory presentation: [The LDBC Social Network Benchmark](https://docs.google.com/presentation/d/1p-nuHarSOKCldZ9iEz__6_V3sJ5kbGWlzZHusudW_Cc/) ([PDF](https://ldbcouncil.org/docs/presentations/ldbc-snb-2021-12.pdf)).



## Implementations

The repository contains the following implementations:

* [`Trillion Graph Schema Setup`](tigergraph/ddl/schema.gsql): an implementation about the 108T graph schema setup demonstrating how to triple the LDBC SNB SF30k dataset
* [`Loading job`](tigergraph/ddl/load_dynamic.gsql): an implementation about loading jobs demonstrating how the graph loads 108T raw data. 
* [`Queries`](tigergraph/queries):  queries expressed in the [GSQL language](https://www.tigergraph.com/gsql/) with modification to ensure that most queries can activate the whole 108TB dataset
* [`Reproducing 108T SNB BI Experiment`](tigergraph/benchmark_on_cluster/README.md): step-by-step instructions of how to reproduce the 108T SNB BI experiment

 



