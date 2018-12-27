package net.zettroke.oblakotodo;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.koushikdutta.async.future.FutureCallback;
import com.koushikdutta.ion.Ion;

import java.util.ArrayList;

public class TodoCreateActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {
    String[] data;
    ArrayList<Integer> ids;
    int current_id = -1;
    boolean inited = false;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_todo_create);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        ids = getIntent().getBundleExtra("bundle").getIntegerArrayList("ids");

        ArrayList<String> titles = getIntent().getBundleExtra("bundle").getStringArrayList("titles");
        data = titles.toArray(new String[titles.size()]);

        Spinner spinner = findViewById(R.id.spinner);


        //Creating the ArrayAdapter instance having the country list
        ArrayAdapter aa = new ArrayAdapter(this, android.R.layout.simple_spinner_item, data);
        aa.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        //Setting the ArrayAdapter data on the Spinner
        spinner.setAdapter(aa);

        spinner.setOnItemSelectedListener(this);
    }

    public void onClickExit(View v){
        finish();
    }

    public void onClickAdd(View v){
        String text = ((TextView) findViewById(R.id.editText)).getText().toString();
        Ion.with(this)
                .load(getString(R.string.server_url) + "/todos")
                .setBodyParameter("project_id", "" + current_id)
                .setBodyParameter("text", text)
                .asByteArray()
                .setCallback(new FutureCallback<byte[]>() {
                    @Override
                    public void onCompleted(Exception e, byte[] result) {
                        finish();
                    }
                });
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        current_id = ids.get(position);
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }
}
