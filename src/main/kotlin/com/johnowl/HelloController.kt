package com.johnowl

import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get

@Controller
class HelloController {

    @Get( "/")
    fun getMessage(): Message {
        return Message("Hello world!")
    }

}