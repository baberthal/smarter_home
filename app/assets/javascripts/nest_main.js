var nestToken = Cookies.get('nest_token'),
    thermostat = {},
    structure = {};

if (nestToken) {
    var dataRef = new Firebase('wss://developer-api.nest.com');
    dataRef.auth(nestToken);

    // TODO: Handle errors gracefully
} else {
    window.location.replace('/auth/nest');
}

// vim: set ts=8 sw=4 tw=0 ft=javascript et :
