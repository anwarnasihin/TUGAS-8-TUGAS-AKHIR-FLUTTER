plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // INI CARA YANG BENAR UNTUK KOTLIN (.kts):
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.finalproject"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Pastikan ID ini sesuai dengan yang ada di google-services.json kamu
        applicationId = "com.example.finalproject"
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Tambahkan Firebase BOM di sini
    implementation(platform("com.google.firebase:firebase-bom:33.7.0"))
    // Tambahkan library auth jika perlu (opsional karena sudah ada BOM)
    implementation("com.google.firebase:firebase-auth") 
}