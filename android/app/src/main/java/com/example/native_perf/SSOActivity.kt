package com.example.native_perf

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.facebook.*
import com.facebook.login.LoginManager
import com.facebook.login.LoginResult
import com.facebook.login.widget.LoginButton
import io.flutter.Log
import org.json.JSONObject

class SSOActivity : AppCompatActivity() {

    private lateinit var callbackManager: CallbackManager
    private lateinit var loginButton: LoginButton

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_s_s_o)
        loginButton = findViewById(R.id.login_button)
        callbackManager = CallbackManager.Factory.create()
        loginButton.setPermissions(listOf("email"))
        loginButton.registerCallback(callbackManager,object: FacebookCallback<LoginResult> {
            override fun onSuccess(result: LoginResult?) {
                Log.d("from Facebook Button", "Success")
            }

            override fun onCancel() {
                Log.d("from Facebook Button", "Cancel")
            }

            override fun onError(error: FacebookException?) {
                Log.d("from Facebook Button", "error: $error")
            }

        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        callbackManager.onActivityResult(requestCode,resultCode,data)
        super.onActivityResult(requestCode, resultCode, data)

        val graphRequest: GraphRequest = GraphRequest.newMeRequest(AccessToken.getCurrentAccessToken(),object:
            GraphRequest.GraphJSONObjectCallback {
            override fun onCompleted(obj: JSONObject?, response: GraphResponse?) {
                Log.d("from Facebook Button", "Completed ${obj.toString()}")
                var name:String = obj?.getString("name") ?: "Not Found"
                intent.putExtra("name",name)
                setResult(RESULT_OK, intent)
                finish()
            }
        })


        val bundle = Bundle()
        bundle.putString("fields","name,id,first_name,last_name,email")
        graphRequest.parameters = bundle
        graphRequest.executeAsync()

    }

    var accessTokenTracker: AccessTokenTracker =object: AccessTokenTracker(){
        override fun onCurrentAccessTokenChanged(oldAccessToken: AccessToken?, currentAccessToken: AccessToken?) {
            if (currentAccessToken == null){
                LoginManager.getInstance().logOut()
            }
        }

    }

    override fun onDestroy() {
        super.onDestroy()
        accessTokenTracker.stopTracking()
    }
}