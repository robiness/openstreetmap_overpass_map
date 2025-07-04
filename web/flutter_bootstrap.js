{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    
    const splashScreen = document.getElementById("splash-screen");
    if (splashScreen) {
      splashScreen.style.opacity = '0';
      setTimeout(() => {
        splashScreen.remove();
      }, 1000);
    }

    await appRunner.runApp();
  }
}); 