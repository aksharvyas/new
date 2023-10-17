/// applicationId : "string"
/// appuserId : "7e8f46f6-4e62-4250-92ad-8ceffbf91903"
/// PermissionGivenBy : "08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4"

class RequestPlacesWithGuestPermissions {
  String? _applicationId;
  String? _appuserId;
  String? _permissionGivenBy;

  String? get applicationId => _applicationId;
  String? get appuserId => _appuserId;
  String? get permissionGivenBy => _permissionGivenBy;

  RequestPlacesWithGuestPermissions({
    String? applicationId,
    String? appuserId,
    String? permissionGivenBy}){
    _applicationId = applicationId;
    _appuserId = appuserId;
    _permissionGivenBy = permissionGivenBy;
  }

  RequestPlacesWithGuestPermissions.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _appuserId = json["appuserId"];
    _permissionGivenBy = json["PermissionGivenBy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["appuserId"] = _appuserId;
    map["PermissionGivenBy"] = _permissionGivenBy;
    return map;
  }

}

/// value : {"appUserAccessPermissions":[{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Ankita","homeId":"4aa7f003-5e24-4c80-9d78-d75bc1554fd1","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home","homeId":"db1dea27-b5ee-4c35-937f-0806e7cd8592","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"57e03940-277c-4088-a02b-0a7777b0cd6a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"fc38acd8-92e0-4ec1-a52e-104aca8d1f77","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e39f5705-8c67-4c52-8f1b-15ebb1f38b72","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"496152c1-a240-4a72-961b-194614e6a02e","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"2289e8be-f6b2-4656-94cb-1b75cea600ad","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e0e2c8e9-c538-4082-b1ff-1e367c434d2b","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"0f4f8b83-655a-4ae4-bfec-1ea265554357","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"de8f215d-add4-49f6-976f-20e240a663ed","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"b6937e2e-8de4-415b-9c17-2bc44fe99521","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e9ed268e-0c93-4407-8ca0-2ea424b7d611","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"3874260a-d84d-4016-833b-2ef74d70b566","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4e45a722-7093-4f63-8d89-3048d359b498","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1fddb2c8-ab85-4c1e-88c4-32c698d496b7","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"a36148aa-b13f-43c8-acf4-342fe21bc8fb","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"d75afd60-c618-4263-94e0-36af371bc358","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"57a00e16-86f7-4386-8b5b-4895a3594672","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"64cab060-d958-44bc-a2c8-4c578d818436","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"c4ed9177-3b2e-41c6-aeac-4c7462958686","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"ceff4447-2efd-4414-b56c-4ed776c46c02","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"d680be21-0d0f-4e5e-a50a-5fb6943e3d58","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"164711c8-a044-4c65-af35-611e7277a223","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"3d0f31e9-4779-4ab8-a898-62be6c78c7aa","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"6df81c78-a87d-40d0-a429-6baaefbb7f28","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e8eec6df-f631-4815-94a2-70a28807cc8a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1a329627-5457-4e43-999d-73cd470861a4","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"da7d7365-8511-4650-bcd0-7bac85dbbf6f","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"15eee7bf-cc2a-4efe-aa7e-7cb00a233954","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e03162b8-12ef-4643-a28c-7d8f8f011b81","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"df744ff2-9e9c-429a-b2cf-861bbf93b78d","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4c9f0cbf-914e-452b-b1b5-8638bf1428b8","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"2be30c7e-1c80-4fd1-b4e6-8c09207e2135","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"47e25882-4d8f-4660-ad97-8d5eec21a334","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"8069ebd3-33bb-400b-87e5-8e737363b45b","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"46b95a94-b7c7-4539-a3f5-8e7924cdad81","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"98813118-a26f-4767-a515-93bd4688172e","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"a5e02681-bba9-4415-a05a-9873a8ee700a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"bf5040eb-6dd7-41cc-babb-9a0c53fa0ab6","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"122e1957-ec64-402d-833c-9faf9a35bbd6","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"f967bc2c-b061-4456-a249-a0c54098fe2e","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1becf83d-6cae-47e0-b51c-a6f5fe8fe1ef","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"a93a877b-696b-4a11-985f-aaa28dc128aa","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4875b4ee-18f1-4a17-beff-ae3c109350ae","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"62f6145c-6635-4a17-a65f-bae6db8fbf06","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"7edacf72-d1e9-42db-b66c-be0349a07181","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4799fd71-4d6b-4593-9a9a-bf73dd9c95ca","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"0e6c3be4-8f60-49a4-b25e-cdb76418f3d8","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"27568486-d05e-4fb4-9bf7-d5aaaf078f4d","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"352b8404-cc29-48fd-ab5f-e8f873c8df97","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"21ce6310-ec5c-40ac-9406-edeee3814797","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1ead6c9a-1707-42cb-b9e3-f064708dcd58","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"8f2bbd15-20da-4170-9f61-f14b4dc88f9c","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"new","homeId":"d34f5c97-682b-45f1-96cc-8ed0d42fbb97","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"qwwee","homeId":"f8fb4765-d60f-4c50-a640-035a35e9a24c","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108}],"meta":{"message":"success.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponsePlacesWithGuestPermissions {
  Value? _value;
  List<dynamic>? _formatters;
  List<dynamic>? _contentTypes;
  dynamic? _declaredType;
  int? _statusCode;

  Value? get value => _value;
  List<dynamic>? get formatters => _formatters;
  List<dynamic>? get contentTypes => _contentTypes;
  dynamic? get declaredType => _declaredType;
  int? get statusCode => _statusCode;

  ResponsePlacesWithGuestPermissions({
    Value? value,
    List<dynamic>? formatters,
    List<dynamic>? contentTypes,
    dynamic? declaredType,
    int? statusCode}){
    _value = value;
    _formatters = formatters;
    _contentTypes = contentTypes;
    _declaredType = declaredType;
    _statusCode = statusCode;
  }

  ResponsePlacesWithGuestPermissions.fromJson(dynamic json) {
    _value = json["value"] != null ? Value.fromJson(json["value"]) : null;
    // if (json["formatters"] != null) {
    //   _formatters = [];
    //   json["formatters"].forEach((v) {
    //     _formatters?.add(dynamic.fromJson(v));
    //   });
    // }
    // if (json["contentTypes"] != null) {
    //   _contentTypes = [];
    //   json["contentTypes"].forEach((v) {
    //     _contentTypes?.add(dynamic.fromJson(v));
    //   });
    // }
    _declaredType = json["declaredType"];
    _statusCode = json["statusCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_value != null) {
      map["value"] = _value?.toJson();
    }
    if (_formatters != null) {
      map["formatters"] = _formatters?.map((v) => v.toJson()).toList();
    }
    if (_contentTypes != null) {
      map["contentTypes"] = _contentTypes?.map((v) => v.toJson()).toList();
    }
    map["declaredType"] = _declaredType;
    map["statusCode"] = _statusCode;
    return map;
  }

}

/// appUserAccessPermissions : [{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Ankita","homeId":"4aa7f003-5e24-4c80-9d78-d75bc1554fd1","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home","homeId":"db1dea27-b5ee-4c35-937f-0806e7cd8592","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"57e03940-277c-4088-a02b-0a7777b0cd6a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"fc38acd8-92e0-4ec1-a52e-104aca8d1f77","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e39f5705-8c67-4c52-8f1b-15ebb1f38b72","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"496152c1-a240-4a72-961b-194614e6a02e","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"2289e8be-f6b2-4656-94cb-1b75cea600ad","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e0e2c8e9-c538-4082-b1ff-1e367c434d2b","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"0f4f8b83-655a-4ae4-bfec-1ea265554357","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"de8f215d-add4-49f6-976f-20e240a663ed","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"b6937e2e-8de4-415b-9c17-2bc44fe99521","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e9ed268e-0c93-4407-8ca0-2ea424b7d611","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"3874260a-d84d-4016-833b-2ef74d70b566","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4e45a722-7093-4f63-8d89-3048d359b498","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1fddb2c8-ab85-4c1e-88c4-32c698d496b7","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"a36148aa-b13f-43c8-acf4-342fe21bc8fb","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"d75afd60-c618-4263-94e0-36af371bc358","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"57a00e16-86f7-4386-8b5b-4895a3594672","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"64cab060-d958-44bc-a2c8-4c578d818436","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"c4ed9177-3b2e-41c6-aeac-4c7462958686","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"ceff4447-2efd-4414-b56c-4ed776c46c02","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"d680be21-0d0f-4e5e-a50a-5fb6943e3d58","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"164711c8-a044-4c65-af35-611e7277a223","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"3d0f31e9-4779-4ab8-a898-62be6c78c7aa","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"6df81c78-a87d-40d0-a429-6baaefbb7f28","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e8eec6df-f631-4815-94a2-70a28807cc8a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1a329627-5457-4e43-999d-73cd470861a4","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"da7d7365-8511-4650-bcd0-7bac85dbbf6f","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"15eee7bf-cc2a-4efe-aa7e-7cb00a233954","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e03162b8-12ef-4643-a28c-7d8f8f011b81","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"df744ff2-9e9c-429a-b2cf-861bbf93b78d","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4c9f0cbf-914e-452b-b1b5-8638bf1428b8","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"2be30c7e-1c80-4fd1-b4e6-8c09207e2135","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"47e25882-4d8f-4660-ad97-8d5eec21a334","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"8069ebd3-33bb-400b-87e5-8e737363b45b","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"46b95a94-b7c7-4539-a3f5-8e7924cdad81","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"98813118-a26f-4767-a515-93bd4688172e","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"a5e02681-bba9-4415-a05a-9873a8ee700a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"bf5040eb-6dd7-41cc-babb-9a0c53fa0ab6","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"122e1957-ec64-402d-833c-9faf9a35bbd6","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"f967bc2c-b061-4456-a249-a0c54098fe2e","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1becf83d-6cae-47e0-b51c-a6f5fe8fe1ef","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"a93a877b-696b-4a11-985f-aaa28dc128aa","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4875b4ee-18f1-4a17-beff-ae3c109350ae","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"62f6145c-6635-4a17-a65f-bae6db8fbf06","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"7edacf72-d1e9-42db-b66c-be0349a07181","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"4799fd71-4d6b-4593-9a9a-bf73dd9c95ca","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"0e6c3be4-8f60-49a4-b25e-cdb76418f3d8","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"27568486-d05e-4fb4-9bf7-d5aaaf078f4d","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"352b8404-cc29-48fd-ab5f-e8f873c8df97","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"21ce6310-ec5c-40ac-9406-edeee3814797","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"1ead6c9a-1707-42cb-b9e3-f064708dcd58","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"8f2bbd15-20da-4170-9f61-f14b4dc88f9c","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"new","homeId":"d34f5c97-682b-45f1-96cc-8ed0d42fbb97","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108},{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"qwwee","homeId":"f8fb4765-d60f-4c50-a640-035a35e9a24c","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-11-15T12:12:27","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":108}]
/// meta : {"message":"success.","status":"success","code":1}

class Value {
  List<AppUserAccessGuestPermissions>? _appUserAccessPermissions;
  Meta? _meta;

  List<AppUserAccessGuestPermissions>? get appUserAccessPermissions => _appUserAccessPermissions;
  Meta? get meta => _meta;

  Value({
    List<AppUserAccessGuestPermissions>? appUserAccessPermissions,
    Meta? meta}){
    _appUserAccessPermissions = appUserAccessPermissions;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["appUserAccessPermissions"] != null) {
      _appUserAccessPermissions = [];
      json["appUserAccessPermissions"].forEach((v) {
        _appUserAccessPermissions?.add(AppUserAccessGuestPermissions.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_appUserAccessPermissions != null) {
      map["appUserAccessPermissions"] = _appUserAccessPermissions?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "success."
/// status : "success"
/// code : 1

class Meta {
  String? _message;
  String? _status;
  int? _code;

  String? get message => _message;
  String? get status => _status;
  int? get code => _code;

  Meta({
    String? message,
    String? status,
    int? code}){
    _message = message;
    _status = status;
    _code = code;
  }

  Meta.fromJson(dynamic json) {
    _message = json["message"];
    _status = json["status"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["status"] = _status;
    map["code"] = _code;
    return map;
  }

}

/// appUserId : "7e8f46f6-4e62-4250-92ad-8ceffbf91903"
/// homeName : "Ankita"
/// homeId : "4aa7f003-5e24-4c80-9d78-d75bc1554fd1"
/// isOwner : false
/// isAdditionalAdmin : false
/// isAdditionalUser : true
/// createdDateTime : "2022-11-15T12:12:27"
/// permissionGivenBy : "08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4"
/// permissionId : 108

class AppUserAccessGuestPermissions {
  String? _appUserId;
  String? _homeName;
  String? _homeId;
  bool? _isOwner;
  bool? _isAdditionalAdmin;
  bool? _isAdditionalUser;
  String? _createdDateTime;
  String? _permissionGivenBy;
  int? _permissionId;
  bool? _isSelected = false;

  String? get appUserId => _appUserId;
  String? get homeName => _homeName;
  String? get homeId => _homeId;
  bool? get isOwner => _isOwner;
  bool? get isAdditionalAdmin => _isAdditionalAdmin;
  bool? get isAdditionalUser => _isAdditionalUser;
  String? get createdDateTime => _createdDateTime;
  String? get permissionGivenBy => _permissionGivenBy;
  int? get permissionId => _permissionId;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  AppUserAccessGuestPermissions({
    String? appUserId,
    String? homeName,
    String? homeId,
    bool? isOwner,
    bool? isAdditionalAdmin,
    bool? isAdditionalUser,
    String? createdDateTime,
    String? permissionGivenBy,
    int? permissionId}){
    _appUserId = appUserId;
    _homeName = homeName;
    _homeId = homeId;
    _isOwner = isOwner;
    _isAdditionalAdmin = isAdditionalAdmin;
    _isAdditionalUser = isAdditionalUser;
    _createdDateTime = createdDateTime;
    _permissionGivenBy = permissionGivenBy;
    _permissionId = permissionId;
  }

  AppUserAccessGuestPermissions.fromJson(dynamic json) {
    _appUserId = json["appUserId"];
    _homeName = json["homeName"];
    _homeId = json["homeId"];
    _isOwner = json["isOwner"];
    _isAdditionalAdmin = json["isAdditionalAdmin"];
    _isAdditionalUser = json["isAdditionalUser"];
    _createdDateTime = json["createdDateTime"];
    _permissionGivenBy = json["permissionGivenBy"];
    _permissionId = json["permissionId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["appUserId"] = _appUserId;
    map["homeName"] = _homeName;
    map["homeId"] = _homeId;
    map["isOwner"] = _isOwner;
    map["isAdditionalAdmin"] = _isAdditionalAdmin;
    map["isAdditionalUser"] = _isAdditionalUser;
    map["createdDateTime"] = _createdDateTime;
    map["permissionGivenBy"] = _permissionGivenBy;
    map["permissionId"] = _permissionId;
    return map;
  }

}