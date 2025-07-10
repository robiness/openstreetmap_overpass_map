#!/usr/bin/env dart

import 'dart:io';

/// Automated deployment script for Overpass Map Explorer
/// Builds the Flutter web app and deploys to Netlify
void main(List<String> args) async {
  print('🚀 Starting Overpass Map Explorer deployment...\n');

  try {
    // Step 2: Clean previous build
    await _runCommand('flutter', ['clean'], 'Cleaning previous build');

    // Step 3: Get dependencies
    await _runCommand('flutter', ['pub', 'get'], 'Getting dependencies');

    // Step 4: Build for web (credentials loaded from .env file)
    await _runCommand('flutter', [
      'build',
      'web',
      '--release',
      '--wasm',
    ], 'Building Flutter web app');

    // Step 4: Deploy to Netlify
    final deployArgs = ['deploy', '--dir=build/web'];

    // Check if we should deploy to production
    if (args.contains('--prod') || args.contains('--production')) {
      deployArgs.add('--prod');
      print('📦 Deploying to PRODUCTION...');
    } else {
      print('🔧 Deploying to PREVIEW...');
      print('💡 Use --prod flag to deploy to production');
    }

    await _runCommand('netlify', deployArgs, 'Deploying to Netlify');

    print('\n✅ Deployment completed successfully!');
    print('🌐 Your app should be available at: https://tgmp.netlify.app');
  } catch (e) {
    print('\n❌ Deployment failed: $e');
    exit(1);
  }
}

/// Runs a command and handles output/errors
Future<void> _runCommand(
  String command,
  List<String> args,
  String description,
) async {
  print('⏳ $description...');

  final process = await Process.start(command, args);

  // Stream output in real-time
  process.stdout.listen((data) {
    stdout.add(data);
  });

  process.stderr.listen((data) {
    stderr.add(data);
  });

  final exitCode = await process.exitCode;

  if (exitCode != 0) {
    throw Exception(
      'Command "$command ${args.join(' ')}" failed with exit code $exitCode',
    );
  }

  print('✅ $description completed\n');
}
