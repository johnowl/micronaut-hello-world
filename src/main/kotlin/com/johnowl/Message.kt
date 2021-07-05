package com.johnowl

import io.micronaut.core.annotation.Introspected

@Introspected
data class Message(
    val message: String
)