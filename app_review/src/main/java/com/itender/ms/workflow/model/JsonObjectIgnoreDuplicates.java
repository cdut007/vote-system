package com.itender.ms.workflow.model;

import org.json.JSONException;
import org.json.JSONObject;

public class JsonObjectIgnoreDuplicates extends JSONObject {


    public JsonObjectIgnoreDuplicates() {
        super();
    }

    public JsonObjectIgnoreDuplicates(String json) {
        super(json);
    }

    public JsonObjectIgnoreDuplicates(JSONTokenerIgnoreDuplicates x) {
        super(x);
    }

    @Override
    public JsonObjectIgnoreDuplicates putOnce(String key, Object value) throws JSONException {
        if (key != null) {
            if (this.opt(key) != null ) {
                System.out.println("Duplicate key \"" + key + "\"");
            }
            this.put(key, value);
        }

        return this;
    }


}