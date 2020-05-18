---
title: "Associating Management OData Entities | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 947a3add-3593-400d-8144-8b44c8adbe5e
caps.latest.revision: 5
---
# Associating Management OData Entities

It is often useful to create an association between two different Management OData entities. For example, a Management OData service could have entities that manage a catalogue of products that are organized in categories, and define the entities `Product` and `Category`. By associating these two entities, a client can get information about all of the products in a category with a single request to the web service.

A sample that shows how to create associations between entities can be downloaded at [Association sample](https://code.msdn.microsoft.com:443/windowsdesktop/Association-sample-0f0fa87e).

## Creating the Association in the resource schema file

The following MOF defines two entities. We will create an association between them.

```csharp
class Product {

[key] string ProductName;

// other fields ...
};

class Category {

[key] string CategoryName;

string Products[];

// other fields
}
```

The `Category` class defines a property that is an array of the names of the products that belong to that category.

To associate two entities, you must define a class with the `Association` attribute in the resource schema MOF file for the service. The class must define the two entities to be associated, called `ends` of the association. The following example shows a definition of a class that defines an association between the Category and Products entities.

```csharp
[Association]
class ProductCategory {
Category ref theCategory;
Product ref theProducts;
}
```

You must also change the declaration of the Products property in the Category class. You use the `AssociationClass` keyword to specify that the property is one end of the association. The property must also be defined as a reference to a separate entity, rather than an array of strings. You do this by using the `ref` keyword. The following example shows the property definition for the association.

```csharp
class Sample_Category {

[key] string CategoryName;

[AssociationClass("Sample_ProductCategory"),ToEnd("theProducts")]
Sample_Product ref AssociatedProducts[];
};
```

Finally, you must declare the other end of the association by adding a property definition to the `Product` class. This is a reference to either an array or to a single entity. Assuming that each product belongs to only one category, the definition would be as follows.

```csharp
class Sample_Product {

[key] string ProductName;
[AssociationClass("Sample_ProductCategory"),ToEnd("theCategory")]
Sample_Category ref AssociatedCategory;
};
```

The properties that represent the two ends of the association are called navigation properties.

#### Steps for associating entities in the resource schema file

- Define the association as a class by using the `Association` keyword.

- Define the ends of the association by using the AssociationClass keyword to qualify properties of the associated entities.

## Creating the association in the resource mapping XML file

There are three different cases to consider when mapping an association in the resource mapping XML file.

#### Determining how to associate entities in the resource mapping file

- If the navigation property is present in the underlying. .NET Framework type, and that property contains foreign keys, no explicit mapping is necessary.

- If the navigation property does not exist in the underlying .NET Framework type, you must specify a cmdlet that retrieves the list of keys of the associated instances. You do this by adding an `Association` element nested under the `CmdletImplementation` element, following the elements that define the `cmdlets` for the other CRUD commands.

  ```xml
  Class Name=" Category">
     <CmdletImplementation>
        <Query> ... </Query>
        <Associations>
           <Field>
              <Name>AssociatedProducts</Name>
              <GetReference>
                 <Cmdlet>Get-ProductsInCategory</Cmdlet>
                 <ParameterForThisObject>Category</ParameterForThisObject>
              </GetReference>
           </Field>
        </Associations>
     </CmdletImplementation>
  </Class>
  ```

- If the navigation property does exist in the underlying .NET Framework type, but it contains object instances instead of foreign keys, then you must create a cmdlet (by writing a Windows PowerShell function or script) to retrieve the foreign keys. You then specify that cmdlet in the resource mapping file. For example, the script to retrieve the keys would look like the following.

  ```
  Param(
      [string] $Key
      )

  (get-category $key).AssociatedProducts

  ```

  And the XML in the resource mapping file would look like the following.

  ```xml
  Class Name=" Category">
     <CmdletImplementation>
        <Query> ... </Query>
        <Associations>
           <Field>
              <Name>AssociatedProducts</Name>
              <GetReference>
                 <Cmdlet>Get-ProductsInCategory.ps1</Cmdlet>
                 <ParameterForThisObject>Category</ParameterForThisObject>
              </GetReference>
           </Field>
        </Associations>
     </CmdletImplementation>
  </Class>
  ```

- In addition to specifying a cmdlet to retrieve the associated entities, you can also specify cmdlets to add and remove references from the collection. The following example assumes that the Add-ProductToCategory and Remove-ProductFromCategory cmdlets exist (they can also be defined in a script or function as in the previous example).

  ```xml
  Class Name="Sample.Category">
     <CmdletImplementation>
        <Query> ... </Query>
        <Associations>
           <Field>
              <Name>AssociatedProducts</Name>
              <GetReference>
  ...
              </GetReference>
        <AddReference>
     <CmdletName>"Add-ProductToCategory"</>
     <ParameterForThisObject>"Product"</>
     <ParameterForReferredObject>"Category"</>
        </AddReference>
        <RemoveReference>
     <CmdletName="Remove-ProductFromCategory"/>
     <ParameterForThisObject >"Product"</>
     <ParameterForReferredObject >"Category"</>
        </RemoveReference>
           </Field>
        </Associations>
     </CmdletImplementation>
  </Class>
  ```

## Querying associated entities

The client can retrieve a list of the instances associated with an entity by creating specific queries.

#### Constructing queries for associated entities

- A client can request the details of a category without retrieving its associated products. For example, the following request gets details of the `food` category.

  ```
  http://localhost:7000/MODataSvc/sample.svc/Category('food')
  ```

  To get the associated products of the category (but not details of the category itself, the client specifies the navigation property in the request.

  ```
  http://localhost:7000/MODataSvc/sample.svc/Category('food')/AssociatedProducts
  ```

- To retrieve only URLs of the products, use the `$links` qualifier in the request.

  ```
  http://localhost:7000/MODataSvc/sample.svc/Category('food')/$links/AssociatedProducts
  ```

- The client can get both the category details and its associated products by using the `$expand` qualifier.

  ```
  http://localhost:7000/MODataSvc/sample.svc/Category('food')?$expand=AssociatedProducts
  ```

## See Also

[Creating a Management OData IIS Extension Web Service](./creating-a-management-odata-web-service.md)
