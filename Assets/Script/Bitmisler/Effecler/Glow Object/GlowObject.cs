using TMPro;
using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class GlowObject : MonoBehaviour
{
    // Bu objenin normal Texture lu materiali meshRendere atanmalı
    // Glow Materiali ise MeshRenderere Emission Texture eklendikten sonra atanmalı 
    [Header("Script Atamaları")]
    [SerializeField] private MeshFilter myMesh;
    [SerializeField] private int myMaterialIndex; // Glow Materialin MeshRendererdeki indexi
    private Material myMaterial;
    private float myHeight;

    private void Start()
    {
        myHeight = myMesh.mesh.bounds.size.y;
        myMaterial = GetComponent<MeshRenderer>().material;
        myMaterial.SetFloat("Vector1_ObjectHeight", myHeight);
    }
}