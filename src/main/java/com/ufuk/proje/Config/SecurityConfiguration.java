package com.ufuk.proje.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

import javax.sql.DataSource;

@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
    @Autowired
    private DataSource dataSource;
    @Autowired
    private UserDetailsService userDetailsService;



    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests().antMatchers("/admin/**").authenticated();
        http.authorizeRequests().antMatchers("/**/favicon.ico","/chart/**", "/css/**", "js/**", "/images/**",
                "/vendor/**","/webjars/**","/","/user/**","/login","/**")
                .permitAll();
        http.authorizeRequests().anyRequest().authenticated();
        http.formLogin().loginPage("/login").loginProcessingUrl("/login").failureUrl("/login?loginFailed=true")
                .defaultSuccessUrl("/admin/",true);
        http.logout().logoutUrl("/admin/logout");
        http.csrf().disable();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication().dataSource(dataSource);

        //auth.userDetailsService(userDetailsService);
    }
}
