plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Plugin de Firebase
}

android {
    namespace = "com.juan.solex_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.juan.solex_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")

    // Firebase BoM (gestiona versiones automáticamente)
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    // Dependencias Firebase que quieras usar
    implementation("com.google.firebase:firebase-auth-ktx")      // Autenticación
    implementation("com.google.firebase:firebase-firestore-ktx")  // Base de datos
    implementation("com.google.firebase:firebase-analytics-ktx")  // Analytics (opcional)
}

flutter {
    source = "../.."
}
