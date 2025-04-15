// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../../features/input_forms/form_fields_models.dart';
// import '../../features/input_forms/form_state_provider.dart';

// /// ✅ [ FormBuilderField] - universal reusable field builder
// class FormBuilderField extends HookConsumerWidget {
//   final FormFieldType type;
//   final List<FormFieldType> fields;
//   final bool showToggleVisibility;

//   const FormBuilderField({
//     super.key,
//     required this.type,
//     required this.fields,
//     this.showToggleVisibility = false,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = useTextEditingController();
//     final obscure = useState(true);

//     final provider = formStateNotifierProvider(fields);
//     final state = ref.watch(provider);
//     final notifier = ref.read(provider.notifier);

//     useEffect(() {
//       controller.text = state.valueOf(type);
//       controller.addListener(() => notifier.updateField(type, controller.text));
//       return null;
//     }, [controller]);

//     final isPassword =
//         type == FormFieldType.password || type == FormFieldType.confirmPassword;
//     final isEmail = type == FormFieldType.email;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: controller,
//         obscureText: isPassword && obscure.value,
//         keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//         decoration: InputDecoration(
//           border: const OutlineInputBorder(),
//           filled: true,
//           labelText: _labelFor(type),
//           errorText: state.errorFor(type),
//           prefixIcon: _iconFor(type),
//           suffixIcon:
//               isPassword && showToggleVisibility
//                   ? IconButton(
//                     icon: Icon(
//                       obscure.value ? Icons.visibility_off : Icons.visibility,
//                     ),
//                     onPressed: () => obscure.value = !obscure.value,
//                   )
//                   : null,
//         ),
//       ),
//     );
//   }

//   String _labelFor(FormFieldType type) => switch (type) {
//     FormFieldType.email => 'Email',
//     FormFieldType.password => 'Password',
//     FormFieldType.confirmPassword => 'Confirm Password',
//     FormFieldType.name => 'Name',
//   };

//   Icon _iconFor(FormFieldType type) => switch (type) {
//     FormFieldType.email => const Icon(Icons.email),
//     FormFieldType.password ||
//     FormFieldType.confirmPassword => const Icon(Icons.lock),
//     FormFieldType.name => const Icon(Icons.person),
//   };
// }
