using TMPro;
using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class WarpDriveColor : MonoBehaviour
{
    //[Header("Script Atamaları")]
    private Material myMaterial;
    public Color color;

    private void Start()
    {
        myMaterial = GetComponent<MeshRenderer>().material;
        myMaterial.SetColor("warpColor", color);
    }
}