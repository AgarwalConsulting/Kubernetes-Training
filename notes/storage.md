# Storage

Managing storage is a distinct problem from managing compute instances.

## Volumes

On-disk files in a Container are ephemeral, which presents some problems for non-trivial applications when running in Containers. First, when a Container crashes, kubelet will restart it, but the files will be lost - the Container starts with a clean state. Second, when running Containers together in a Pod it is often necessary to share files between those Containers. The Kubernetes Volume abstraction solves both of these problems.

### Volume types

- **`awsElasticBlockStore`**
- **`azureDisk`**
- `azureFile`
- `cephfs`
- `cinder`
- **`configMap`**
- `csi`
- `downwardAPI`
- `emptyDir`
- `fc` (fibre channel)
- `flexVolume`
- `flocker`
- **`gcePersistentDisk`**
- `gitRepo` (deprecated)
- `glusterfs`
- `hostPath`
- `iscsi`
- **`local`**
- **`nfs`**
- **`persistentVolumeClaim`**
- `projected`
- `portworxVolume`
- `quobyte`
- `rbd`
- `scaleIO`
- **`secret`**
- `storageos`
- `vsphereVolume`

## PersistentVolume

The PersistentVolume subsystem provides an API for users and administrators that abstracts details of how storage is provided from how it is consumed. To do this, we introduce two new API resources: PersistentVolume and PersistentVolumeClaim.

A `PersistentVolume` (PV) is a piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using `Storage Classes`. It is a resource in the cluster just like a node is a cluster resource. PVs are volume plugins like Volumes, but have a lifecycle independent of any individual Pod that uses the PV. This API object captures the details of the implementation of the storage, be that NFS, iSCSI, or a cloud-provider-specific storage system.

## StorageClass

A `StorageClass` provides a way for administrators to describe the "classes" of storage they offer. Different classes might map to quality-of-service levels, or to backup policies, or to arbitrary policies determined by the cluster administrators. Kubernetes itself is unopinionated about what classes represent. This concept is sometimes called "profiles" in other storage systems.

### The StorageClass Resource

Each StorageClass contains the fields `provisioner`, `parameters`, and `reclaimPolicy`, which are used when a PersistentVolume belonging to the class needs to be dynamically provisioned.

The name of a StorageClass object is significant, and is how users can request a particular class. Administrators set the name and other parameters of a class when first creating StorageClass objects, and the objects cannot be updated once they are created.

## Dynamic Volume Provisioning

Users request dynamically provisioned storage by including a storage class in their `PersistentVolumeClaim`. Before Kubernetes v1.6, this was done via the `volume.beta.kubernetes.io/storage-class` annotation. However, this annotation is deprecated since v1.6. Users now can and should instead use the storageClassName field of the PersistentVolumeClaim object. The value of this field must match the name of a StorageClass configured by the administrator (see below).

Dynamic provisioning can be enabled on a cluster such that all claims are dynamically provisioned if no storage class is specified. A cluster administrator can enable this behavior by:
