plugins {
    java
    application
    id("org.springframework.boot") version "3.5.7"
    id("io.spring.dependency-management") version "1.1.7"
}

group = "itmo.code"
version = "1.0-SNAPSHOT"

application {
    mainClass = "itmo.code.App"
}
repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter")
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-devtools")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<Test> {
    useJUnitPlatform()
    outputs.cacheIf { true }
}

tasks.withType<JavaCompile> {
    options.isFork = true
    options.isIncremental = true
}

tasks.withType<Jar> {
    outputs.cacheIf { true }
}