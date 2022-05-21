using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GetTime : MonoBehaviour
{
    public float elapsedTime = 0;
    public Material material;

    private void Awake()
    {
   
    }
    // Start is called before the first frame update
    void Start()
    {
        material = GetComponent<MeshRenderer>().materials[0];
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        elapsedTime += Time.deltaTime;
        material.SetFloat("_elapsedTime", elapsedTime);

    }
}
