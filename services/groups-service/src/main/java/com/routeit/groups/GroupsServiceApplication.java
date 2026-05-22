package com.routeit.groups;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class GroupsServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(GroupsServiceApplication.class, args);
    }
}
