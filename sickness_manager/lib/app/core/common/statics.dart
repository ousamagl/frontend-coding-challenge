class Statics {
  Statics._();

  static const _baseURL =
      'https://absence-manager-api-6c43055a2bde.herokuapp.com';

  static final String loginApi = '$_baseURL/login';
  static final String absencesApi = '$_baseURL/absences';
  static final String membersApi = '$_baseURL/members';
}
