class Response {
    static success(data, next = null) {
        return JSON.stringify({status: true, data: data, next: next});
    }

    static error(message) {
        return JSON.stringify({status: false, error: message});
    }
}

