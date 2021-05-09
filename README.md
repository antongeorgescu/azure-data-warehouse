### Introduction

There are many ways to skin a cat in Azure, and that is quite applicable to the case when you need to build a Data Warehouse. For the purpose of this presentation we will cover two design choices: one that uses Azure Synapse / Power BI, the other one that uses Azure Sql Server / Power BI.

##### Deploy an on-prem Sql Server database

For the purpose of demonstrating the two different implementations of an Azure Data Warehouse, we will need to setup a sample data source, in the shape of a database deployed on-prem (your own local machine.) This database is a sample of Student Courses information and has the following schema.

![Student-Courses-DB-Schema](https://user-images.githubusercontent.com/6631390/117579152-a6495d00-b0bf-11eb-9a2e-4a66bb1fd3be.PNG)

The following 2 Sql scripts are used to create a new instance of StudentCourses database and populate it with sample data.

[Create_StudentCoursesDatabase.sql](https://https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/Create_StudentCoursesDatabase.sql)

[Populate_StudentCoursesDatabase.sql](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/Populate_StudentCoursesDatabase.sql)

*Note*: The following two views are providing the data sources for two parquet files that will be uploaded in Azure Blob Storage (schemas are provided under each):

[Create_vwInstructorCourseDepartment.sql](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/create_vwInstructorCourseDepartment.sql)

![vwInstructorCourseDepartment](https://user-images.githubusercontent.com/6631390/117579387-a007b080-b0c0-11eb-93de-bfd244907191.PNG)

[Create_vwStudentCourseGrade.sql](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/create_vwStudentCourseGrade.sql)

![vwStudentCourseGrade](https://user-images.githubusercontent.com/6631390/117579425-c3326000-b0c0-11eb-8721-a1e730ad792f.PNG)

##### Generate parquet files from data source

The Python script under [studentdb_to_parquet.py](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/PythonScripts/studentdb_to_parquet.py) extracts the data from sample database and creates a parquet file (as alternatives, csv and json files can be created as well.)

![python_dataframe_to_parquet](https://user-images.githubusercontent.com/6631390/117580178-b0218f00-b0c4-11eb-9696-d545e3035802.PNG)

### Data Warehouse with Azure Synapse

---

#### What is Azure Synapse

Azure Synapse is an enterprise analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse brings together the best of SQL technologies used in enterprise data warehousing, Spark technologies used for big data, Pipelines for data integration and ETL/ELT, and deep integration with other Azure services such as Power BI, CosmosDB, and AzureML.

#### Apache Spark

Apache Spark is a lightning-fast cluster computing designed for fast computation. It was built on top of Hadoop MapReduce and it extends the MapReduce model to efficiently use more types of computations which includes Interactive Queries and Stream Processing.

#### Azure Data Lake Storage

Combines the power of a Hadoop compatible file system with integrated hierarchical namespace with the massive scale and economy of Azure Blob Storage to help speed your transition from proof of concept to production.

### Data Warehouse with Azure Sql Server

---

#### Solution Overview

In a Data Lake model on Azure Cloud, data generally lands on the Azure storage layer using the Azure Blob Storage, especially for semi-structured data. Data may be exported from various data sources in the form of JSON, CSV, Parquet, ORC and various formats and hosted on blob storage, from where it would be channeled to other purpose-specific repositories. Azure SQL Database is one of the most popular data repositories for hosting structured data on the Azure cloud. From this perspective, Azure blob storage is one of the most frequently used data sources and Azure SQL Database is of the most frequently used data destinations. Azure Data Factory on Azure cloud helps to transport and transform data from-and-to to a variety of data repositories. In this article, we will learn how to use Azure Data Factory to populate data from Azure Blob Storage to Azure SQL Database.

#### Azure Block Blobs Storage

It is a scalable object storage for documents, videos, pictures and unstructured text or binary data. Choose from Hot, Cool or Archive tiers.

#### Initial Setup

In this approach, we will source data from Azure Blob storage and populate the same into Azure SQL Database. For this, we need a few items to be set up, before we can start focusing on the actual exercise of populating the destination with the source using Azure Data Factory.

##### Steps Required

* Setup an Azure Storage Account

Account name is "alviandastorage" and has the features populated in the snapshot below.

![azurestorage-with-azureblob](https://user-images.githubusercontent.com/6631390/117578631-42259980-b0bd-11eb-9dd5-4b98ea9e5f2a.PNG)

* Create an Azure Blob container associated with the storage account

![azure-blob-containers](https://user-images.githubusercontent.com/6631390/117578759-e8719f00-b0bd-11eb-9fed-48d72f8cb43c.PNG)

* Create an Azure SQL Database hosted on an Azure SQL Server instance.

This would act as the destination where we would populate the data from the source files using the Azure Data Factory.

![azure-sqlserver-database](https://user-images.githubusercontent.com/6631390/117578897-9bda9380-b0be-11eb-8b0f-d56cf3aaa4fa.PNG)

Once the above pre-requisites are setup, we can proceed with the rest of the exercise which would focus on populating the data from source to destination.
