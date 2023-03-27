String? emailValidation(String? value) {
  if (value != null && value.isEmpty) {
    return "メールアドレスを入力してください";
  }
  bool emailValid = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$")
      .hasMatch(value!);
  if (emailValid == false) {
    return "正しいメールアドレスを入力してください";
  }
  return null;
}
