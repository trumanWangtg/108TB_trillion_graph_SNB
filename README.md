![TG_LOGO](https://github.com/trumanWangtg/108TB_trillion_graph_SNB/blob/main/TigerGraph-Logo.png)

# TigerGraph 108 TB Soical Network Graph Implementations

This social network graph loads 108Tb raw data, and contains 217 billion vertices and 1.6 trillion edges/relationships. The 108TB data are inflated based on LDBC SNB official SF-30000 dataset. The LDBC SNB schema and BI workload queries were modified to ensure that most queries can activate the whole 108TB dataset.

 This experiment was carried out on AWS EC2 72 x r6a.48xlarge instances and not using any containerization/virtualization technology.  Full Disclosure Report of the [108T Social Network Benchmark](https://docs.google.com/document/d/1h4PnZGpg8-HYBvIHjjgdeonchZo7hSHfEK8IsTrTZN0/edit). (document to be replaced) 



To get started with LDBC SNB benchmarks, check out the introductory presentation: [The LDBC Social Network Benchmark](https://docs.google.com/presentation/d/1p-nuHarSOKCldZ9iEz__6_V3sJ5kbGWlzZHusudW_Cc/) ([PDF](https://ldbcouncil.org/docs/presentations/ldbc-snb-2021-12.pdf)).



## Implementations

The repository contains the following implementations:

* [`Trillion Graph Schema Setup`](tigergraph/ddl/schema.gsql): an implementation about the 108T graph schema setup demonstrating how to triple the LDBC SNB SF30k dataset
* [`tigergraph`](tigergraph/ddl/load_dynamic.gsql): an implementation about loading jobs demonstrating how the graph loads 108T raw data. 
* [`tigergraph`](tigergraph/queries):  queries expressed in the [GSQL language](https://www.tigergraph.com/gsql/) with modification to ensure that most queries can activate the whole 108TB dataset
 

## Reproducing SNB BI experiments

Running an SNB BI experiment requires the following steps.

1. Pick a system, e.g. [Umbra](umbra/). Make sure you have the required binaries and licenses available.

1. Generate the data sets using the [SNB Datagen](https://github.com/ldbc/ldbc_snb_datagen_spark/) according to the format described in the system's README.

1. Generate the substitution parameters using the [`paramgen`](paramgen/) tool.

1. Load the data set: set the required environment variables and run the tool's `scripts/load-in-one-step.sh` script.

1. Run the benchmark: set the required environment variables and run the tool's `scripts/benchmark.sh` script.

1. Collect the results in the [`output`](output/) directory of the tool.

:warning:
Note that deriving official LDBC results requires commissioning an _audited benchmark_, which is a more complex process as it entails code review, cross-validation, etc.
See [the specification's Auditing chapter](https://ldbcouncil.org/ldbc_snb_docs/ldbc-snb-specification.pdf#chapter.7) for details.

## Cross-validation

To cross-validate the results of two implementations, use two systems.
Load the data into both, then run the benchmark in validation mode, e.g. [Cypher](cypher/) and [Umbra](umbra/) results.
Then, run:

```bash
export SF=10

cd cypher
scripts/benchmark.sh --validate
cd ..

cd umbra
scripts/benchmark.sh --validate
cd ..

scripts/cross-validate.sh cypher umbra
```

Note that the cross-validation uses the [numdiff](scripts/numdiff.md) CLI tool.



## Data sets

Data sets are also being uploaded to the [SURF CWI repository](https://repository.surfsara.nl/datasets/cwi/snb) and expected to be published there in 2023.
