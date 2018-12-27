package net.zettroke.oblakotodo;

import android.content.Intent;
import android.content.res.ColorStateList;
import android.graphics.Paint;
import android.graphics.drawable.ColorDrawable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.koushikdutta.async.future.FutureCallback;
import com.koushikdutta.ion.Ion;

import java.util.ArrayList;

import uk.co.chrisjenx.calligraphy.CalligraphyConfig;

public class MainActivity extends AppCompatActivity {

    private JsonArray data = new JsonArray();
    ListView list_view;
    Adapter adapter;

    private class CheckboxLisner implements CheckBox.OnCheckedChangeListener{
        private int id;
        public CheckboxLisner(int id) {
            this.id = id;
        }

        @Override
        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
            if (isChecked){
                buttonView.setPaintFlags(buttonView.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
            }else{
                buttonView.setPaintFlags(buttonView.getPaintFlags() & ~Paint.STRIKE_THRU_TEXT_FLAG);
            }
            Ion.with(getApplicationContext())
                    .load(getString(R.string.server_url) + "/todos/" + id)
                    .setByteArrayBody(new byte[0])
                    .asByteArray()
                    .setCallback(new FutureCallback<byte[]>() {
                        @Override
                        public void onCompleted(Exception e, byte[] result) {
                            System.out.println();
                        }
                    });

            Log.d("Checkbox", "id: " + ((JsonObject) buttonView.getTag()).get("id").getAsInt());
            //System.out.println("Id:");
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        update_data();
    }

    private class Adapter extends BaseAdapter{
        @Override
        public int getCount() {
            return data.size();
        }

        @Override
        public Object getItem(int position) {
            return null;
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            JsonObject obj = data.get(position).getAsJsonObject();
            View v = getLayoutInflater().inflate(R.layout.task, null);
            TextView tx = v.findViewById(R.id.task_header);
            tx.setText(obj.get("title").getAsString());
            LinearLayout l = v.findViewById(R.id.checkbox_container);
            for (JsonElement el: obj.get("todos").getAsJsonArray()){
                JsonObject todo = el.getAsJsonObject();
                CheckBox c = new CheckBox(getApplicationContext());
                c.setTag(todo);
                c.setText(todo.get("text").getAsString());
                boolean check = !todo.get("isCompleted").isJsonNull() && todo.get("isCompleted").getAsBoolean();
                c.setChecked(check);
                if (check){
                    c.setPaintFlags(c.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
                }
                c.setTextSize(TypedValue.COMPLEX_UNIT_PT, 10);
                c.setOnCheckedChangeListener(new CheckboxLisner(todo.get("id").getAsInt()));
                c.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.accentColor)));
                l.addView(c);
            }

            return v;
        }
    }



    private void update_data(){
        Ion.with(this)
                .load(getString(R.string.server_url) + "/get_json")
                .asJsonArray()
                .setCallback(new FutureCallback<JsonArray>() {
                    @Override
                    public void onCompleted(Exception e, JsonArray result) {
                        if (e == null) {
                            data = result;
                            adapter.notifyDataSetChanged();
                        }
                    }
                });
    }

    public void onClick(View v){

        Bundle b = new Bundle();
        ArrayList<String> titles = new ArrayList<>();
        ArrayList<Integer> ids = new ArrayList<>();

        for (JsonElement el: data){
            JsonObject o = el.getAsJsonObject();
            titles.add(o.get("title").getAsString());
            ids.add(o.get("id").getAsInt());
        }

        b.putStringArrayList("titles", titles);
        b.putIntegerArrayList("ids", ids);

        Intent intent = new Intent(this, TodoCreateActivity.class);
        intent.putExtra("bundle", b);
        startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        CalligraphyConfig.initDefault(new CalligraphyConfig.Builder()
                .setDefaultFontPath("fonts/OpenSans-Light.ttf")
                .setFontAttrId(R.attr.fontPath)
                .build());

        setContentView(R.layout.activity_main);

        list_view = (ListView)findViewById(R.id.list_view);
        adapter = new Adapter();

        update_data();

        list_view.setDivider(new ColorDrawable(getResources().getColor(R.color.backgroundColor)));
        list_view.setDividerHeight(20);

        list_view.setAdapter(adapter);


    }
}
