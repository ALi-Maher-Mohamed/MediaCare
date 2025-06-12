import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Ai_feature/robot_view.dart';

class ModernErrorScreen extends StatefulWidget {
  final FlutterErrorDetails? errorDetails;
  final String? customTitle;
  final String? customMessage;
  final VoidCallback? onRetry;
  final VoidCallback? onBackToHome;

  const ModernErrorScreen({
    Key? key,
    this.errorDetails,
    this.customTitle,
    this.customMessage,
    this.onRetry,
    this.onBackToHome,
  }) : super(key: key);

  @override
  State<ModernErrorScreen> createState() => _ModernErrorScreenState();
}

class _ModernErrorScreenState extends State<ModernErrorScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _bounceController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _bounceController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  String _getErrorTitle() {
    if (widget.customTitle != null) return widget.customTitle!;

    if (widget.errorDetails?.exception != null) {
      final exception = widget.errorDetails!.exception;
      if (exception is FormatException) return 'Data Format Error';
      if (exception.toString().toLowerCase().contains('network'))
        return 'Network Error';
      if (exception.toString().toLowerCase().contains('timeout'))
        return 'Request Timeout';
      if (exception.toString().toLowerCase().contains('connection'))
        return 'Connection Failed';
    }

    return 'Oops! Something went wrong';
  }

  String _getErrorMessage() {
    if (widget.customMessage != null) return widget.customMessage!;

    if (widget.errorDetails?.exception != null) {
      final exception = widget.errorDetails!.exception;

      if (exception is FormatException) {
        return 'We received unexpected data. Please try again later.';
      }

      // Generic message based on exception type
      final exceptionStr = exception.toString().toLowerCase();
      if (exceptionStr.contains('network') ||
          exceptionStr.contains('connection')) {
        return 'Unable to connect to the server. Please check your internet connection.';
      }
      if (exceptionStr.contains('timeout')) {
        return 'The operation timed out. Please try again.';
      }
    }

    return 'We encountered an unexpected error. Don\'t worry, it\'s not your fault!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.indigo.shade50,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Error Image
                  ScaleTransition(
                    scale: _bounceAnimation,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/shy.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to icon if image fails to load
                            return Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red.shade400,
                                    Colors.pink.shade400,
                                    Colors.purple.shade400,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.error_outline_rounded,
                                size: 80,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Error Title
                  SlideTransition(
                    position: _slideAnimation,
                    child: Text(
                      _getErrorTitle(),
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                letterSpacing: -0.5,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Error Message
                  SlideTransition(
                    position: _slideAnimation,
                    child: Text(
                      _getErrorMessage(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Action Buttons
                  SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        // Back to Home Button (Always Visible)
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: widget.onBackToHome ??
                                () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/',
                                    (route) => false,
                                  );
                                },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadowColor: Colors.deepPurple.withOpacity(0.3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.home_rounded),
                                const SizedBox(width: 8),
                                Text(
                                  'العودة للصفحة الرئيسية',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Retry Button (Optional)
                        if (widget.onRetry != null)
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: widget.onRetry,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                                side: BorderSide(
                                  color: Colors.deepPurple.shade200,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.refresh_rounded),
                                  const SizedBox(width: 8),
                                  Text(
                                    'إعادة المحاولة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Decorative Elements
                  SlideTransition(
                    position: _slideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 800 + (index * 200)),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example usage with FlutterErrorDetails
class ErrorScreenDemo extends StatelessWidget {
  const ErrorScreenDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example FlutterErrorDetails
    final errorDetails = FlutterErrorDetails(
      exception: Exception('Network connection failed'),
      stack: StackTrace.current,
      library: 'demo_app',
      context: ErrorDescription('Error occurred while fetching data'),
    );

    return MaterialApp(
      title: 'Modern Error Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: ModernErrorScreen(
        errorDetails: errorDetails,
    
        onRetry: () {
          // Handle retry logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Retrying...')),
          );
        },
        onBackToHome: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RobotView(),
              ));
        },
      ),
    );
  }
}

// Example of how to use it in error handling
void handleError(FlutterErrorDetails details) {
  // Navigate to error screen

  MaterialPageRoute(
    builder: (context) => ModernErrorScreen(
      errorDetails: details,
      onRetry: () {
        Navigator.pop(context);
        // Retry the failed operation
      },
      onBackToHome: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RobotView(),
            ));
      },
    ),
  );
}
