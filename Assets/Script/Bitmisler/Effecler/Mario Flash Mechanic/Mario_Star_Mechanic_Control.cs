using UnityEngine;

public class Mario_Star_Mechanic_Control : MonoBehaviour
{
    [Header("Script Atamaları")]
    [SerializeField] private bool isActive;
    private Material myMaterial;

    private void Start()
    {
        myMaterial = GetComponent<MeshRenderer>().material;
    }

    private void Update()
    {
        if (isActive)
        {
            myMaterial.EnableKeyword("ISACTIVE_ON");
            myMaterial.DisableKeyword("ISACTIVE_OFF");
        }
        else
        {
            myMaterial.EnableKeyword("ISACTIVE_OFF");
            myMaterial.DisableKeyword("ISACTIVE_ON");
        }
    }
}