![TG_LOGO](https://github.com/trumanWangtg/108TB_trillion_graph_SNB/blob/main/common/TigerGraph-Logo.png)

# TigerGraph 108 TB Soical Network Graph Implementations
To get started with LDBC SNB benchmarks, check out the introductory presentation: [The LDBC Social Network Benchmark](https://docs.google.com/presentation/d/1p-nuHarSOKCldZ9iEz__6_V3sJ5kbGWlzZHusudW_Cc/) ([PDF](https://ldbcouncil.org/docs/presentations/ldbc-snb-2021-12.pdf)).

The following high-level summary highlights the novelties in numbers:
* Overall, the full source dataset is about 108TB, containing 1.619 trillion relationships and 218 billion vertices. 
* Total benchmark time is 35.4 hours, including the initial data loading, 1 power batch run, and 1 throughput batch run. (Each batch runs all BI queries for 5 times.)
* Hardware cost is $843/hr, including 72 AWS r6a.48xlarge machines and 432T GP3 SSD volumes.
* The 108TB data are inflated based on LDBC SNB official SF-30000 dataset. The LDBC SNB schema and BI workload queries were modified to ensure that most queries can activate the whole 108TB dataset.

 This experiment was carried out with TigerGraph Version 3.7.0 and not using any containerization/virtualization technology.  Full Disclosure Report of the [108T Social Network Benchmark](https://docs.google.com/document/d/1h4PnZGpg8-HYBvIHjjgdeonchZo7hSHfEK8IsTrTZN0/edit). (document to be replaced) 


## Methodology
The LDBC_SNB SF-30k data generator produces 44TB of raw data, consisting of 36.5TB in the initial snapshot and 7TB in the form of inserts and deletes. The initial snapshot includes 36TB of dynamic data, which can be altered through daily batch updates, and less than 1TB of static data, which remains unchanged.

To increase the volume of data, the 36TB of dynamic vertex and edge types were replicated three times, including Comment, Person, Post, Forum, and their associated edges. This resulted in a total of more than 108TB of raw data loaded into TigerGraph. For instance, the new graph schema includes Comment1, Comment2, and Comment3. All dynamic vertex types are connected to the original static vertex types, forming a single, cohesive graph. There are no subgraphs or disconnected elements, allowing for BI queries to traverse the entire 108TB of data. Accordingly, it is necessary to substitute the original dynamic vertex types with the tripled dynamic vertex types in BI queries to ensure proper functioning.
## Implementations

The repository contains the following implementations:

* [`Trillion Graph Schema Setup`](tigergraph/ddl/schema.gsql): an implementation about the 108T graph schema setup demonstrating how to triple the LDBC SNB SF30k dataset
* [`Loading job`](tigergraph/ddl/load_dynamic.gsql): an implementation about loading jobs demonstrating how the graph loads 108T raw data. 
* [`Queries`](tigergraph/queries):  queries expressed in the [GSQL language](https://www.tigergraph.com/gsql/) with modification to ensure that most queries can activate the whole 108TB dataset
* [`Reproducing 108T SNB BI Experiment`](tigergraph/benchmark_on_cluster/README.md): step-by-step instructions of how to reproduce the 108T SNB BI experiment

 ## Query Modifications 

 * [`Loading job`](tigergraph/ddl/load_dynamic.gsql): an implementation about loading jobs demonstrating how the graph loads 108T raw data. 




