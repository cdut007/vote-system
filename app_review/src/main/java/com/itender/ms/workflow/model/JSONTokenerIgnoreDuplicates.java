package com.itender.ms.workflow.model;

import org.json.JSONException;
import org.json.JSONTokener;

public class JSONTokenerIgnoreDuplicates extends JSONTokener {

    public JSONTokenerIgnoreDuplicates(String s) {
        super(s);
    }

    @Override
    public Object nextValue() throws JSONException {
        char c = this.nextClean();
        String string;

        switch (c) {
            case '"':
            case '\'':
                return this.nextString(c);
            case '{':
                this.back();
                return new JsonObjectIgnoreDuplicates(this);
            case '[':
                this.back();
                return new JsonObjectIgnoreDuplicates(this);
        }

        StringBuilder sb = new StringBuilder();
        while (c >= ' ' && ",:]}/\\\"[{;=#".indexOf(c) < 0) {
            sb.append(c);
            c = this.next();
        }
        this.back();

        string = sb.toString().trim();
        if ("".equals(string)) {
            throw this.syntaxError("Missing value");
        }
        return JsonObjectIgnoreDuplicates.stringToValue(string);
    }

}