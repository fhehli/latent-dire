from typing import List

from torch.utils.data import DataSet, DataLoader, random_split
from torchvision.datasets import ImageFolder

from nn.resnet50 import preprocess_resnet50_pixel

"""
This assumes we have organized the data in the following way:
    root
    ├── real
    └── fake
"""


def get_dataloaders(root: str, batch_size: int, shuffle: bool = True) -> List[DataLoader, DataLoader, DataLoader]:
    dataset = ImageFolder(root, transform=preprocess_resnet50_pixel)
    train_dataset, val_dataset, test_dataset = random_split(dataset, lenghts=[0.8, 0.1, 0.1])
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
    val_loader = DataLoader(val_dataset, batch_size=batch_size, shuffle=True)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=True)

    return train_loader, val_loader, test_loader
