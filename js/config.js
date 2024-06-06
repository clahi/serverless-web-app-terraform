window._config = {
    cognito: {
        userPoolId: aws_cognito_user_pool.WildRydes.id, // e.g. us-east-2_uXboG5pAb
        userPoolClientId: aws_amplify_app.my-amplify-app.id, // e.g. 25ddkmj4v6hfsfvruhpfi7n4hv
        region: 'us-east-1' // e.g. us-east-2
    },
    api: {
        invokeUrl: 'https://97i5ptgjlj.execute-api.us-east-1.amazonaws.com/prod' // e.g. https://rc7nyt4tql.execute-api.us-west-2.amazonaws.com/prod',
    }
};
