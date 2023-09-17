part of kocek_pin_fields;

/// Don't forget to set a child foreground color to white
class KocekPinGradiented extends StatelessWidget {
  const KocekPinGradiented({required this.child, required this.gradient});

  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) =>
      ShaderMask(shaderCallback: gradient.createShader, child: child);
}