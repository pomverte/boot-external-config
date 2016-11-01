# Spring Boot External Config

> Make Jar, not War !

## Build it
```mvn clean install```

## Run it
```java -jar boot-external-config-0.0.1.jar```

## Check it out
http://localhost:8080/

```value = [default]```

## Configure it
### Config file
Create a file named `application.properties` with the following content :
```
app.value = It works !
```

### Option 1
Add the `application.properties` in the same directory than the jar file
```
.
├── boot-external-config-0.0.1.jar
└── application.properties
```

### Option 2
Add the `application.properties` in a subdirectory named `config`
```
.
├── boot-external-config-0.0.1.jar
└── config
    └── application.properties
```

Many more options here :
http://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html

### Result
```value = [It works !]```

