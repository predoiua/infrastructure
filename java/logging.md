# slf4j + logback

- Maven

~~~
	<dependency>
		<groupId>org.slf4j</groupId>
		<artifactId>jcl-over-slf4j</artifactId>
		<version>${jcl.slf4j.version}</version>
	</dependency>
	<dependency>
		<groupId>ch.qos.logback</groupId>
		<artifactId>logback-classic</artifactId>
		<version>${logback.version}</version>
	</dependency>
~~~

#  Logback

- logback.xml in resources folder
- To enable debug for a package

~~~
    <logger name="com.vv10" level="debug" additivity="false">
        <appender-ref ref="STDOUT" />
    </logger>
~~~

- without additivity="false" , log mess will be written in all appenders
