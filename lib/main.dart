import 'package:flutter/material.dart';
import 'services/company_service.dart';
import 'widgets/company_grid.dart';
import 'widgets/company_details_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizWiz',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final companyService = CompanyService();
    final companies = companyService.getAllCompanies();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BizWiz'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CompanyGrid(
        companies: companies,
        onCompanyTap: (company) {
          showDialog(
            context: context,
            builder: (context) => CompanyDetailsDialog(company: company),
          );
        },
      ),
    );
  }
}
