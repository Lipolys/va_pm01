# bikeapi.api.BikeControllerApi

## Load the API package
```dart
import 'package:bikeapi/api.dart';
```

All URIs are relative to *http://127.0.0.1:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create**](BikeControllerApi.md#create) | **POST** /api/v1/bike | 
[**getById**](BikeControllerApi.md#getbyid) | **GET** /api/v1/bike/{id} | 
[**listAll**](BikeControllerApi.md#listall) | **GET** /api/v1/bike | 
[**remove**](BikeControllerApi.md#remove) | **DELETE** /api/v1/bike/{id} | 
[**update**](BikeControllerApi.md#update) | **PUT** /api/v1/bike/{id} | 


# **create**
> BikeDTO create(createBikeDTO)



End point para inclusão de dado

### Example
```dart
import 'package:bikeapi/api.dart';

final api_instance = BikeControllerApi();
final createBikeDTO = CreateBikeDTO(); // CreateBikeDTO | 

try {
    final result = api_instance.create(createBikeDTO);
    print(result);
} catch (e) {
    print('Exception when calling BikeControllerApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createBikeDTO** | [**CreateBikeDTO**](CreateBikeDTO.md)|  | 

### Return type

[**BikeDTO**](BikeDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById**
> BikeDTO getById(id)



End point para obter dados por id

### Example
```dart
import 'package:bikeapi/api.dart';

final api_instance = BikeControllerApi();
final id = 789; // int | 

try {
    final result = api_instance.getById(id);
    print(result);
} catch (e) {
    print('Exception when calling BikeControllerApi->getById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BikeDTO**](BikeDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAll**
> List<BikeDTO> listAll()



lista todos os estudantes

### Example
```dart
import 'package:bikeapi/api.dart';

final api_instance = BikeControllerApi();

try {
    final result = api_instance.listAll();
    print(result);
} catch (e) {
    print('Exception when calling BikeControllerApi->listAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<BikeDTO>**](BikeDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **remove**
> BikeDTO remove(id)



End point para remover dados por id

### Example
```dart
import 'package:bikeapi/api.dart';

final api_instance = BikeControllerApi();
final id = 789; // int | 

try {
    final result = api_instance.remove(id);
    print(result);
} catch (e) {
    print('Exception when calling BikeControllerApi->remove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BikeDTO**](BikeDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update**
> BikeDTO update(id, updateBikeDTO)



End point para atualização de dados

### Example
```dart
import 'package:bikeapi/api.dart';

final api_instance = BikeControllerApi();
final id = 789; // int | 
final updateBikeDTO = UpdateBikeDTO(); // UpdateBikeDTO | 

try {
    final result = api_instance.update(id, updateBikeDTO);
    print(result);
} catch (e) {
    print('Exception when calling BikeControllerApi->update: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **updateBikeDTO** | [**UpdateBikeDTO**](UpdateBikeDTO.md)|  | 

### Return type

[**BikeDTO**](BikeDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

