using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotation : MonoBehaviour
{
    private float speed = 5;
    private float maxX = 4;
    private float minX = -4;
    // Start is called before the first frame update

    Vector3 movement;
    void Start()
    {
        movement = transform.position;
    }
    // Update is called once per frame
    void Update()
    {
        transform.Translate(speed * Time.deltaTime, 0, 0);
        ////gameObject.transform.rotation.x = 10;
       if(transform.position.x >= maxX)
        {
            speed = speed * -1;
            
        }
        if (transform.position.x <= minX)
        {
            speed = speed * -1;

        }

    }
}
