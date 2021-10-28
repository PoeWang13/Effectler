using TMPro;
using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class Mask3D_Controller : MonoBehaviour
{
    [Header("Script Atamaları")]
    [SerializeField] private Transform player;
    private Vector3 oldPlayerPosition;
    private Material material;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player").transform;
        material = GetComponent<MeshRenderer>().material;
        SetPlayerPosition();
    }
    private void Update()
    {
        if (oldPlayerPosition != player.position)
        {
            SetPlayerPosition();
        }
    }
    private void SetPlayerPosition()
    {
        if (player != null)
        {
            material.SetVector("Vector4_PlayerPos", player.position);
            oldPlayerPosition = player.position;
        }
    }
}