using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class blurOnClick : MonoBehaviour
{
    //private Material material;
    private float blur_effect;
    // Start is called before the first frame update
    void Start()
    {
        //material = gameObject.GetComponent<Material>();
       // material.shader = Shader.Find("image_kernal_edge_detection");
        blur_effect = 0;
        Debug.Log("use Left Click to increase blur");
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            //on click adds blur
            blur_effect += .01f;
            Debug.Log(blur_effect);
            gameObject.GetComponent<Renderer>().sharedMaterial.SetFloat("_Blur", blur_effect);
        }
        if(blur_effect > 0.10f)
        {
            blur_effect = 0.0f;
        }
        //resets after it hits 0.1;
    }
}
