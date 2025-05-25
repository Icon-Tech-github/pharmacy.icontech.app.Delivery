Padding(
  padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
  child: TextFormField(
    textAlignVertical: TextAlignVertical.center,
    textInputAction: TextInputAction.done,
    style: TextStyle(fontSize: 18.0, height: size.height * .0025),
    keyboardType: TextInputType.visiblePassword,
    cursorColor: AppTheme.kPrimary,
    obscureText: !_passwordVisible,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.Required.tr(); // رسالة خطأ إذا كانت الحقل فارغًا
      } else if (value.length < 6) {
        return LocaleKeys.password_valid.tr(); // رسالة خطأ إذا كانت كلمة المرور أقل من 6 أحرف
      } else if (value != "your_correct_password") { // التحقق من كلمة المرور الصحيحة
        return LocaleKeys.invalid_password.tr(); // رسالة خطأ إذا كانت كلمة المرور غير صحيحة
      }
      return null; // لا يوجد خطأ
    },
    onSaved: (val) {
      context.read<AuthCubit>().password = val!;
    },
    decoration: _inputDecoration(LocaleKeys.password.tr(), true),
  ),
),
